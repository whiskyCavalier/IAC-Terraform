terraform {
  backend "s3" {
    bucket         = "your-tf-state-bucket"
    key            = "iac-mc/aws/prod/terraform.tfstate"
    region         = "us-east-2"
    dynamodb_table = "your-tf-locks"
    encrypt        = true
  }
}
