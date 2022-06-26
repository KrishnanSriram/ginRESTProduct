<!-- BEGIN_TF_DOCS -->
## Requirements

- go
- docker
- terraform

## Install Dependencies
```sh
make tfinstalldeps
```
## Create Azure Container Instance
```sh
make APP_NAME=<app-name> IMAGE_TAG=<image-tag> SUBSCRIPTION_ID=<subscription-id> create-container-instance
#example
make APP_NAME=goginrestsid IMAGE_TAG=v1.1 SUBSCRIPTION_ID=00000000-0000-0000-0000-000000000000 create-container-instance 
```
## Destory Terraform
```sh
make tfdestroy SUBSCRIPTION_ID=<subscription-id>
#example
make tfdestroy SUBSCRIPTION_ID=00000000-0000-0000-0000-000000000000
```



