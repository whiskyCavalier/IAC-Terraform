# Local Dev

## Prereqs
- Terraform >= 1.6
- AWS CLI / Azure CLI / gcloud (as needed)
- Credentials configured

## Backends
- AWS: S3 + DynamoDB
- Azure: azurerm backend (Storage Account + container)
- GCP: GCS backend (bucket)

## Commands
```bash
make fmt
cd terraform/envs/aws-dev && terraform init && terraform apply
cd terraform/envs/azure-dev && terraform init && terraform apply
cd terraform/envs/gcp-dev && terraform init && terraform apply
```
