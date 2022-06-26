output "acr_login_server" {
  value = azurerm_container_registry.acr.login_server
  description = "azure acr server endpoint."
}

output "acr_admin_user" {
  value = var.admin_enabled ? azurerm_container_registry.acr.admin_username : null
  description = "azure acr admin username."
}

output "acr_admin_password" {
  value = var.admin_enabled ? azurerm_container_registry.acr.admin_password : null
  sensitive = true
  description = "azure acr admin password."
}

output "acr_name" {
  value = azurerm_container_registry.acr.name
  description = "azure acr name."
}

output "container_ip_address" {
  value = azurerm_container_group.app.ip_address
  description = "container instance ip address."
}