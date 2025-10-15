.PHONY: fmt aws-dev azure-dev gcp-dev

fmt:
	terraform fmt -recursive

aws-dev:
	cd terraform/envs/aws-dev && terraform init && terraform apply -auto-approve

azure-dev:
	cd terraform/envs/azure-dev && terraform init && terraform apply -auto-approve

gcp-dev:
	cd terraform/envs/gcp-dev && terraform init && terraform apply -auto-approve
