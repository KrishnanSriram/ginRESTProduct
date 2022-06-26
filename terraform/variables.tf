variable "app_name" {
    default = "goginrest"
    description = "name of the application."
}

variable "image_tag" {
    default = "v1.0"
    description = "image tag version."
}

variable "region" {
    default = "eastus"
    description = "Azure region name."
}

variable "subscription_id" {
    description = "azure subscription id."
}

variable "sku" {
    default = "Basic"
    description = "Azure Container Registry service tier (Basic|Standard|Premium)"
}

variable "admin_enabled" {
    default = true
    description = "flag to enable admin account on acr."
    type = bool
}