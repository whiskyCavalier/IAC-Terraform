<h1 align="center">IaC Starter (Multi‑Cloud): Terraform modules for AWS • Azure • GCP</h1>

<p align="center">
  <a href="./docs/architecture.md">Architecture</a> ·
  <a href="./docs/LOCAL_DEV.md">Local Dev</a>
</p>

This repository is a **production-friendly starter** that demonstrates how to design **reusable Infrastructure-as-Code (IaC)** modules across **AWS, Azure, and Google Cloud**.

- Reusable modules for **networking** and a **serverless HTTP API** in each cloud.
- Separate **environment folders** per cloud (`aws-dev`, `azure-dev`, `gcp-dev`, etc.).
- CI (GitHub Actions), pre-commit hooks, Makefile, and docs.
- Example CloudFormation (AWS) stays included to show parity with Terraform.

> Goal: a consistent developer experience across clouds—same variable names and outputs wherever possible.

## Layout
```
terraform/
  modules/
    aws/{network,lambda_api}
    azure/{network,function_api}
    gcp/{network,function_api}
  envs/
    aws-dev/      # S3 backend (state) + AWS providers
    aws-prod/
    azure-dev/    # AzureRM backend (state) + Azure providers
    azure-prod/
    gcp-dev/      # GCS backend (state) + Google providers
    gcp-prod/
cloudformation/
  s3-static-website.yaml
.github/workflows/ci.yml
.pre-commit-config.yaml
Makefile
```

## Quickstart
Follow `docs/LOCAL_DEV.md` for cloud-specific steps. TL;DR:

- **AWS (dev)**
  ```bash
  cd terraform/envs/aws-dev
  terraform init
  terraform apply
  ```
- **Azure (dev)**
  ```bash
  cd terraform/envs/azure-dev
  terraform init
  terraform apply
  ```
- **GCP (dev)**
  ```bash
  cd terraform/envs/gcp-dev
  terraform init
  terraform apply
  ```

Each env provisions:
- A VPC/VNet/Network with two subnets
- A serverless HTTP endpoint returning `{ "message": "pong" }`

## Notes
- Modules aim to keep input/output names aligned across clouds (`vpc_id` vs `vnet_id` normalized as `network_id`, etc.).
- Tighten IAM and firewall rules before production. Mind costs for NAT/egress.
