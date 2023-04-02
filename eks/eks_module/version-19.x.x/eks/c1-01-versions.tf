# Terraform Settings Block
terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = ">= 4.47"
     }
  }
  # Adding Backend as S3 for Remote State Storage
  backend "s3" {
    bucket = "backend-terraform-xxxx61401xxxx"
    key    = "infra-structure/aws/xxxx61401xxxx/eks/nimtechnology-devops/terraform.tfstate"
    region = "us-west-2"
 
    # For State Locking
    dynamodb_table = "eks-nimtechnology-devops"    
  }  
}

# Terraform Provider Block
provider "aws" {
  region = var.aws_region
}