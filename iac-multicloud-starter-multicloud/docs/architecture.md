# High-level Architecture

Each cloud deploys:
- A network (VPC/VNet/GCP VPC) with 2 subnets
- A serverless function with an HTTP endpoint returning `{"message":"pong"}`
- Minimal IAM and security groups / firewall rules (harden for production)
