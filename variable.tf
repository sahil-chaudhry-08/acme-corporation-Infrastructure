# Resource Group
variable "rg_name" {
  description = "The name of the resource group."
  type        = string
}

variable "location" {
  description = "The Azure region where resources will be deployed."
  type        = string
  default     = "West Europe"
}

# Service Plan
variable "frontend_service_plan_name" {
  type = string
}

variable "os_type" {
  type = string
}

variable "sku_name" {
  type = string
}

variable "middleware_service_plan_name" {
  type = string
}

# Frontend
variable "frontend_webapp_name" {
  type = string
}

variable "frontend_public_access" {
  type    = bool
  default = true
}

variable "frontend_app_insights" {
  type = string
}

# Middleware
variable "middleware_webapp_name" {
  type = string
}

variable "middleware_public_access" {
  type    = bool
  default = false
}

variable "middleware_app_insights" {
  type = string
}

# Virtual Network
variable "vnet_name" {
  type = string
}

variable "vnet_address_space" {
  type = string
}

variable "frontend_subnet_name" {
  type = string
}

variable "frontend_subnet_address_space" {
  type = string
}

variable "middleware_subnet_name" {
  type = string
}

variable "middleware_subnet_address_space" {
  type = string
}

variable "db_subnet_name" {
  type = string
}

variable "db_subnet_address_space" {
  type = string
}

# SQL
variable "user_assigned_identity_name" {
  type = string
}

variable "mssql_server_name" {
  type = string
}

variable "sql_version" {
  type = string
}

variable "mssql_database_name" {
  type = string
}

variable "mssql_sku" {
  type = string
}

# Keyvault
variable "key_vault_name" {
  type = string
}

variable "sql_key_name" {
  type = string
}