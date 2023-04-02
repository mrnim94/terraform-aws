output "cluster_certificate_authority_data" {
  description = "Base64 encoded certificate data required to communicate with the cluster"
  value       = module.eks.cluster_certificate_authority_data
}

output "cluster_endpoint" {
  description = "Base64 encoded certificate data required to communicate with the cluster"
  value       = module.eks.cluster_endpoint
}

output "cluster_id" {
  description = "Base64 encoded certificate data required to communicate with the cluster"
  value       = module.eks.cluster_id
}

output "oidc_provider_arn" {
  description = "Base64 encoded certificate data required to communicate with the cluster"
  value       = module.eks.oidc_provider_arn
}

output "vpc_id" {
  description = "The ID of the VPC is installed EKS Cluster"
  value       = data.terraform_remote_state.eks.outputs.vpc_id
}