terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.11.0"
    }
  }
  required_version = ">= 0.14.9"
}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

resource "azurerm_resource_group" "rg" {
  name     = format("%s_rg", var.app_name)
  location = var.region
}

resource "azurerm_container_registry" "acr" {
  name                = format("%sregistry", var.app_name)
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = var.sku
  admin_enabled       = var.admin_enabled
}

resource "azurerm_container_group" "app" {
  name                = var.app_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  ip_address_type     = "Public"
  os_type             = "Linux"

  container {
    name   = var.app_name
    image  = format("%s/%s:%s", azurerm_container_registry.acr.login_server, var.app_name, var.image_tag) 
    cpu    = "1"
    memory = "1.5"

    ports {
      port     = 8080
      protocol = "TCP"
    }
  }

  image_registry_credential{
      username = azurerm_container_registry.acr.admin_username
      password = azurerm_container_registry.acr.admin_password
      server = azurerm_container_registry.acr.login_server
  }
}