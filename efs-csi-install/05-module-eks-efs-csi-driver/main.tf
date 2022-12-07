# Input Variables
# AWS Region
variable "aws_region" {
  description = "Region in which AWS Resources to be created"
  type = string
  default = "us-east-1"  
}

# Terraform Remote State Datasource - Remote Backend AWS S3
data "terraform_remote_state" "eks" {
  backend = "s3"
  config = {
    bucket = "terraform-on-aws-eks-nim"
    key    = "dev/eks-cluster/terraform.tfstate"
    region = var.aws_region
  }
}

module "eks-efs-csi-driver" {
  source  = "mrnim94/eks-efs-csi-driver/aws"
  version = "1.0.0"

  aws_region = var.aws_region
  environment = "dev"
  business_divsion = "SAP"

 eks_cluster_certificate_authority_data = data.terraform_remote_state.eks.outputs.cluster_certificate_authority_data
 eks_cluster_endpoint = data.terraform_remote_state.eks.outputs.cluster_endpoint
 eks_cluster_id = data.terraform_remote_state.eks.outputs.cluster_id
 aws_iam_openid_connect_provider_arn = data.terraform_remote_state.eks.outputs.aws_iam_openid_connect_provider_arn
}