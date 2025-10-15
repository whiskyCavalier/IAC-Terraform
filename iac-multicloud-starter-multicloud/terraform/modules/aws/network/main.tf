terraform {
  required_providers {
    aws = { source = "hashicorp/aws", version = ">= 5.0" }
  }
}
resource "aws_vpc" "this" {
  cidr_block           = var.cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = merge(var.tags, { Name = "${var.name}-vpc" })
}
resource "aws_internet_gateway" "igw" { vpc_id = aws_vpc.this.id }
resource "aws_subnet" "public" {
  for_each = toset(var.azs)
  vpc_id = aws_vpc.this.id
  cidr_block = cidrsubnet(var.cidr_block, 8, index(var.azs, each.key) + 1)
  map_public_ip_on_launch = true
}
resource "aws_subnet" "private" {
  for_each = toset(var.azs)
  vpc_id = aws_vpc.this.id
  cidr_block = cidrsubnet(var.cidr_block, 8, index(var.azs, each.key) + 101)
}
