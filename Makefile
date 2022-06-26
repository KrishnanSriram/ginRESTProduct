APP_NAME ?= goginrest
IMAGE_TAG ?= v1.0

check-subscription_id:
ifndef SUBSCRIPTION_ID
	$(error SUBSCRIPTION_ID is not set)
endif

tfinstalldeps:
	@brew bundle --file=Brewfile

tflint:
	@tflint ./terraform -c ./terraform/.tflint.hcl

tfdoc:
	@terraform-docs markdown table --output-file README.md terraform

tfinit: 
	@terraform -chdir=terraform init --upgrade

tfplan: check-subscription_id tfinit
	@terraform -chdir=terraform plan -var="app_name=${APP_NAME}" -var="image_tag=${IMAGE_TAG}" -var="subscription_id=${SUBSCRIPTION_ID}"

tfapply-acr: check-subscription_id tfinit
	@terraform -chdir=terraform apply -target="azurerm_container_registry.acr" -auto-approve -var="app_name=${APP_NAME}" -var="image_tag=${IMAGE_TAG}" -var="subscription_id=${SUBSCRIPTION_ID}"

tfdestroy: check-subscription_id
	@terraform -chdir=terraform destroy -auto-approve -var="subscription_id=${SUBSCRIPTION_ID}"

build-image:
	@docker build -t ${APP_NAME} . --platform linux/amd64

push-image-to-acr: build-image tfapply-acr
	@docker tag ${APP_NAME} $(shell terraform -chdir=terraform output -raw acr_login_server)/${APP_NAME}:${IMAGE_TAG}
	@az acr login --name $(shell terraform -chdir=terraform output -raw acr_name)
	@docker push $(shell terraform -chdir=terraform output -raw acr_login_server)/${APP_NAME}:${IMAGE_TAG}

create-container-instance: check-subscription_id push-image-to-acr
	@terraform -chdir=terraform apply -target="azurerm_container_group.app" -auto-approve -var="app_name=${APP_NAME}" -var="image_tag=${IMAGE_TAG}" -var="subscription_id=${SUBSCRIPTION_ID}"
