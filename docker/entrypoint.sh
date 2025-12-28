#!/bin/bash
set -e

echo "🚀 Iniciando configuração do Laravel..."

echo "⏳ Aguardando banco de dados..."
for i in {1..30}; do
    if mysqladmin ping -h db -u root -proot &> /dev/null 2>&1; then
        echo "✅ MySQL está respondendo!"
        break
    fi
    if [ $i -eq 30 ]; then
        echo "❌ Timeout aguardando MySQL"
        exit 1
    fi
    echo "Aguardando MySQL... (tentativa $i/30)"
    sleep 2
done

echo "⏳ Aguardando MySQL estar totalmente pronto..."
sleep 20

if [ ! -f .env ]; then
    echo "📝 Criando arquivo .env..."
    cat > .env << EOF
APP_NAME="Pizzaria do Cuca"
APP_ENV=local
APP_KEY=
APP_DEBUG=true
APP_URL=http://localhost:8080

DB_CONNECTION=mysql
DB_HOST=db
DB_PORT=3306
DB_DATABASE=pizzaria_do_cuca
DB_USERNAME=pizzaria_user
DB_PASSWORD=root
    EOF
fi

if [ ! -d "vendor" ]; then
    echo "📦 Instalando dependências do Composer..."
    composer install --no-interaction --prefer-dist --optimize-autoloader
fi

echo "🧹 Limpando cache..."
php artisan config:clear || true
php artisan cache:clear || true

if ! grep -q "APP_KEY=base64:" .env 2>/dev/null; then
    echo "🔑 Gerando chave da aplicação..."
    php artisan key:generate --force
fi

if [ ! -L public/storage ]; then
    echo "📁 Configurando storage..."
    php artisan storage:link || true
fi

echo "🗄️  Verificando conexão com banco de dados..."
DB_READY=false
for i in {1..30}; do
    if mysql -h db -u pizzaria_user -proot -e "USE pizzaria_do_cuca; SELECT 1;" &> /dev/null 2>&1; then
        echo "✅ Conexão com banco de dados estabelecida!"
        DB_READY=true
        break
    else
        if [ $i -lt 30 ]; then
            echo "⏳ Tentativa $i/30: Aguardando banco de dados estar pronto..."
            sleep 2
        else
            echo "⚠️  Não foi possível conectar ao banco de dados após 30 tentativas"
        fi
    fi
done

if [ "$DB_READY" = true ]; then
    echo "🗄️  Executando migrações..."
    php artisan migrate --force || echo "⚠️  Não foi possível executar migrações automaticamente. Execute manualmente: docker compose exec app php artisan migrate"
else
    echo "⚠️  Pulando migrações - banco de dados não está pronto. Execute manualmente: docker compose exec app php artisan migrate"
fi

chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache
chmod -R 755 /var/www/html/storage /var/www/html/bootstrap/cache

echo "✅ Configuração concluída!"

exec php-fpm

