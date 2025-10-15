variable "region" { type = string default = "us-east-2" }
variable "project_name" { type = string default = "iac-mc" }
variable "azs" { type = list(string) default = ["us-east-2a","us-east-2b"] }
