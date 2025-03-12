# Resource Group
rg_name  = "acme-corporation-rg"
location = "West Europe"

# Service Plan
frontend_service_plan_name   = "acme-frontent-sp"
os_type                      = "Windows"
sku_name                     = "P0v3"
middleware_service_plan_name = "acme-middleware-sp"

# Frontend
frontend_webapp_name  = "acme-frontend-app" 
frontend_app_insights = "acme-frontend-app-insights" 

# Middleware
middleware_webapp_name  = "acme-middleware-app" 
middleware_app_insights = "acme-middleware-app-insights" 

# Networking
vnet_name           = "acme-vnet"
vnet_address_space  = "10.0.0.0/16"

frontend_subnet_name          = "acme-frontend-subnet"
frontend_subnet_address_space = "10.0.1.0/24"

middleware_subnet_name          = "acme-middleware-subnet"
middleware_subnet_address_space = "10.0.2.0/24"

db_subnet_name          = "acme-db-subnet"
db_subnet_address_space = "10.0.3.0/24"

# SQL
user_assigned_identity_name = "acme-ua-mi"
mssql_server_name           = "acme-sql-server"
sql_version                 = "12.0"
mssql_database_name         = "acme-sql-db"
mssql_sku                   = "P2"

# Keyvault
key_vault_name = "acmekv01"
sql_key_name   = "sql-key"