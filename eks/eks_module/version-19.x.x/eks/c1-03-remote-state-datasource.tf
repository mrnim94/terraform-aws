# Terraform Remote State Datasource - Remote Backend AWS S3
data "terraform_remote_state" "eks" {
  backend = "s3"
  config = {
    bucket = "backend-terraform-xxxx61401xxxx"
    key    = "infra-structure/aws/xxxx61401xxxx/vpc/nimtechnology-devops/terraform.tfstate"
    region = var.aws_region
  }
}