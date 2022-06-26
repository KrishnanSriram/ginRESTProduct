<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14.9 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | 3.11.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.11.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_container_group.app](https://registry.terraform.io/providers/hashicorp/azurerm/3.11.0/docs/resources/container_group) | resource |
| [azurerm_container_registry.acr](https://registry.terraform.io/providers/hashicorp/azurerm/3.11.0/docs/resources/container_registry) | resource |
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/3.11.0/docs/resources/resource_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_enabled"></a> [admin\_enabled](#input\_admin\_enabled) | flag to enable admin account on acr. | `bool` | `true` | no |
| <a name="input_app_name"></a> [app\_name](#input\_app\_name) | name of the application. | `string` | `"goginrest"` | no |
| <a name="input_image_tag"></a> [image\_tag](#input\_image\_tag) | image tag version. | `string` | `"v1.0"` | no |
| <a name="input_region"></a> [region](#input\_region) | Azure region name. | `string` | `"eastus"` | no |
| <a name="input_sku"></a> [sku](#input\_sku) | Azure Container Registry service tier (Basic\|Standard\|Premium) | `string` | `"Basic"` | no |
| <a name="input_subscription_id"></a> [subscription\_id](#input\_subscription\_id) | azure subscription id. | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_acr_admin_password"></a> [acr\_admin\_password](#output\_acr\_admin\_password) | azure acr admin password. |
| <a name="output_acr_admin_user"></a> [acr\_admin\_user](#output\_acr\_admin\_user) | azure acr admin username. |
| <a name="output_acr_login_server"></a> [acr\_login\_server](#output\_acr\_login\_server) | azure acr server endpoint. |
| <a name="output_acr_name"></a> [acr\_name](#output\_acr\_name) | azure acr name. |
| <a name="output_container_ip_address"></a> [container\_ip\_address](#output\_container\_ip\_address) | container instance ip address. |
<!-- END_TF_DOCS -->