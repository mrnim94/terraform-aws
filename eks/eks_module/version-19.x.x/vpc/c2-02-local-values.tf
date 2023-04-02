# Define Local Values in Terraform
locals {
  owners = var.owners
  environment = var.environment
  common_tags = {
    owners = local.owners
    environment = local.environment
  }
  cluster_name = "${local.owners}-${var.business_divsion}"
} 