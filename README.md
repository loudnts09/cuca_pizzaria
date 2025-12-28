# Pizzaria do Cuca

Sistema completo de gerenciamento para pizzaria desenvolvido com Laravel 7, oferecendo uma solução prática e funcional para administração de pedidos, usuários e sabores de pizza.

## Sobre o Projeto

O **Pizzaria do Cuca** é um sistema web desenvolvido com Laravel 7. O sistema permite que clientes realizem pedidos de pizza de forma intuitiva, enquanto administradores gerenciam todo o fluxo de pedidos. O projeto implementa operações CRUD completas seguindo boas práticas de desenvolvimento com Laravel.

## Funcionalidades

### Autenticação e Usuários
- **Registro de usuários**: Cadastro completo com validação de dados
- **Login e logout**: Sistema de autenticação seguro
- **Gerenciamento de perfil**: 
  - Visualização e edição de informações pessoais
  - Upload e atualização de foto de perfil
  - Alteração de senha
  - Exclusão de conta

### Gerenciamento de Pedidos
- **Criação de pedidos**: 
  - Seleção de sabores de pizza
  - Escolha de tamanhos (Pequena, Média, Grande, Família)
  - Definição de quantidades
  - Adição de observações por item
  - Cálculo automático de valores baseado em tamanho e quantidade
- **Visualização de pedidos**: 
  - Listagem de todos os pedidos (admin)
  - Visualização apenas dos próprios pedidos (cliente)
  - Busca e filtros de pedidos
  - Paginação de resultados
- **Edição de pedidos**: Modificação de itens antes da finalização
- **Exclusão de pedidos**: Remoção de pedidos e itens
- **Geração de PDF**: Exportação de pedidos em formato PDF

### Perfis de Usuário
- **Administrador (perfil_id = 1)**: 
  - Visualização de todos os pedidos do sistema
  - Gerenciamento completo de pedidos
- **Cliente (perfil_id = 2)**: 
  - Visualização apenas dos próprios pedidos
  - Criação e edição de seus pedidos

### Gerenciamento de Sabores
- Cadastro e gerenciamento de sabores de pizza
- Definição de preços por sabor
- Relacionamento com itens de pedido

## Tecnologias Utilizadas

### Backend
- **PHP**: >= 7.2.5
- **Laravel**: 7.x
- **MySQL**: Banco de dados relacional

### Frontend
- **Bootstrap**: 4.x
- **HTML5**: Estrutura semântica
- **CSS3**: Estilização
- **JavaScript**: Interatividade

### Bibliotecas e Ferramentas
- **dompdf/dompdf**: ^3.1 - Geração de PDFs
- **doctrine/dbal**: ^3.9 - Abstração de banco de dados
- **Laravel Dusk**: ^6.25.2 - Testes de interface
- **Laravel Mix**: ^5.0.1 - Compilação de assets

## Requisitos do Sistema

- PHP >= 7.2.5
- Composer
- MySQL >= 5.7 ou MariaDB >= 10.2
- Node.js e NPM (para compilação de assets)
- Extensões PHP necessárias:
  - OpenSSL
  - PDO
  - Mbstring
  - Tokenizer
  - XML
  - Ctype
  - JSON
  - BCMath
  - Fileinfo
  - GD2
  - cURL

## Instalação com Docker

O projeto está dockerizado para facilitar o desenvolvimento e garantir consistência entre ambientes. A configuração inicial é feita automaticamente quando os containers são iniciados.

### Pré-requisitos

- Docker >= 20.10
- Docker Compose >= 2.0 (ou `docker compose` plugin)

### Instalação Rápida

1. **Clone o repositório:**

```bash
git clone https://github.com/loudnts09/cuca_pizzaria_laravel.git
cd cuca_pizzaria
```

2. **Inicie o projeto:**

```bash
docker compose up -d --build
```

**Pronto!** A aplicação estará disponível em `http://localhost:8080`

A configuração inicial acontece automaticamente quando os containers são iniciados pela primeira vez.

### O que acontece automaticamente

Quando você executa `docker compose up`, o sistema automaticamente:

- ✅ Cria o arquivo `.env` se não existir
- ✅ Aguarda o banco de dados estar pronto
- ✅ Instala as dependências do Composer
- ✅ Gera a chave da aplicação Laravel
- ✅ Executa as migrações do banco de dados
- ✅ Configura o storage (link simbólico)
- ✅ Ajusta as permissões necessárias

Tudo isso acontece automaticamente na primeira inicialização!

**Nota:** Se as migrações não forem executadas automaticamente na primeira inicialização, você pode executá-las manualmente com: `docker compose exec app php artisan migrate`

### Comandos úteis do Docker

- **Parar os containers:**
```bash
docker compose down
```

- **Ver logs:**
```bash
docker compose logs -f
```

- **Executar comandos Artisan:**
```bash
docker compose exec app php artisan [comando]
```

- **Executar migrações manualmente (se necessário):**
```bash
docker compose exec app php artisan migrate
```

- **Acessar o container da aplicação:**
```bash
docker compose exec app bash
```

- **Acessar o MySQL:**
```bash
docker compose exec db mysql -u pizzaria_user -proot pizzaria_do_cuca
```

- **Reconstruir os containers:**
```bash
docker compose up -d --build
```

## Instalação Tradicional (sem Docker)

### 1. Clone o repositório

```bash
git clone https://github.com/loudnts09/cuca_pizzaria_laravel.git
cd cuca_pizzaria
```

### 2. Instale as dependências do Composer

```bash
composer install
```

### 3. Configure o ambiente

Copie o arquivo `.env.example` para `.env`:

```bash
cp .env.example .env
```

Gere a chave da aplicação:

```bash
php artisan key:generate
```

### 4. Configure o banco de dados

Edite o arquivo `.env` e configure as credenciais do banco de dados:

```env
DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=pizzaria_do_cuca
DB_USERNAME=seu_usuario
DB_PASSWORD=sua_senha
```

### 5. Configure as extensões PHP

Certifique-se de que as seguintes extensões estão habilitadas no seu `php.ini`:

```ini
extension=openssl
extension=curl
extension=pdo_mysql
extension=mbstring
extension=mysqli
extension=fileinfo
extension=gd2
```

### 6. Execute as migrações

Crie as tabelas do banco de dados:

```bash
php artisan migrate
```

### 7. Configure o storage

Crie o link simbólico para o storage público:

```bash
php artisan storage:link
```

### 8. Compile os assets (opcional)

Se desejar compilar os assets frontend:

```bash
npm install
npm run dev
# ou para produção
npm run production
```

### 9. Inicie o servidor de desenvolvimento

```bash
php artisan serve
```

A aplicação estará disponível em `http://127.0.0.1:8000`

## Estrutura do Projeto

```
cuca_pizzaria/
├── app/
│   ├── Console/
│   ├── Exceptions/
│   ├── Http/
│   │   ├── Controllers/
│   │   │   ├── HomeController.php
│   │   │   ├── ItemPedidoController.php
│   │   │   ├── LoginController.php
│   │   │   ├── PedidoController.php
│   │   │   └── PessoaController.php
│   │   └── Middleware/
│   ├── Item_pedido.php
│   ├── Pedido.php
│   ├── Perfis.php
│   ├── Sabor.php
│   └── User.php
├── config/
├── database/
│   ├── migrations/
│   └── seeds/
├── docker/
│   ├── nginx/
│   │   └── default.conf
│   ├── php/
│   │   └── local.ini
│   └── entrypoint.sh
├── public/
│   ├── imagens/
│   └── style.css
├── resources/
│   ├── js/
│   ├── sass/
│   └── views/
│       ├── app/
│       └── site/
├── routes/
│   └── web.php
├── tests/
├── Dockerfile
├── docker-compose.yml
└── .dockerignore
```

## Estrutura do Banco de Dados

### Principais Tabelas

- **users**: Armazena informações dos usuários (nome, email, senha, CPF, telefone, foto, perfil)
- **perfis**: Define os perfis de acesso (Administrador, Cliente)
- **pedidos**: Registra os pedidos realizados (usuário, status, valor)
- **sabores**: Cadastro de sabores de pizza disponíveis
- **itens_pedido**: Itens individuais de cada pedido (sabor, tamanho, quantidade, observação)

## Como Usar

### Para Clientes

1. **Cadastro**: Acesse `/cadastro` e preencha seus dados
2. **Login**: Faça login com suas credenciais
3. **Criar Pedido**: 
   - Acesse "Novo Pedido"
   - Selecione sabores, tamanhos e quantidades
   - Adicione observações se necessário
   - Finalize o pedido
4. **Visualizar Pedidos**: Acesse "Meus Pedidos" para ver seus pedidos
5. **Editar Perfil**: Acesse "Perfil" para atualizar suas informações

### Para Administradores

1. Faça login com credenciais de administrador
2. Acesse "Meus Pedidos" para visualizar todos os pedidos do sistema
3. Utilize a busca para filtrar pedidos
4. Gerencie pedidos conforme necessário

## Segurança

- Autenticação de usuários com middleware `auth`
- Senhas criptografadas com bcrypt
- Validação de dados em formulários
- Proteção CSRF habilitada
- Upload de arquivos validado (tipo e tamanho)

## Testes

O projeto inclui testes com Laravel Dusk. Para executar:

**Com Docker:**
```bash
docker compose exec app php artisan dusk
```

**Sem Docker:**
```bash
php artisan dusk
```

## Rotas Principais

- `/` - Página de login
- `/cadastro` - Registro de novos usuários
- `/home` - Dashboard principal (após login)
- `/perfil` - Gerenciamento de perfil
- `/pedidos/novo` - Criar novo pedido
- `/pedidos/meus` - Listar pedidos
- `/pedidos/meus/editar/{pedido}` - Editar pedido
- `/pedidos/pdf` - Exportar pedido em PDF

