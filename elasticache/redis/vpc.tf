
# Create VPC Terraform Module
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.11.0"
  #version = "~> 3.11"

  # VPC Basic Details
  name = local.redis_cluster_name
  cidr = var.vpc_cidr_block
  azs             = data.aws_availability_zones.available.names
  public_subnets  = var.vpc_public_subnets
  private_subnets = var.vpc_private_subnets  

  #Elasticache Subnets
  elasticache_subnets = var.vpc_elasticache_subnets
  create_elasticache_subnet_group = var.vpc_create_elasticache_subnet_group
  create_elasticache_subnet_route_table = var.vpc_create_elasticache_subnet_route_table
  # create_elasticache_internet_gateway_route = true
  # create_elasticache_nat_gateway_route = true
  
  # NAT Gateways - Outbound Communication
  enable_nat_gateway = var.vpc_enable_nat_gateway 
  single_nat_gateway = var.vpc_single_nat_gateway

  # VPC DNS Parameters
  enable_dns_hostnames = true
  enable_dns_support   = true

  
  tags = local.common_tags
  vpc_tags = local.common_tags

  # Additional Tags to Subnets
  public_subnet_tags = {
    Type = "Public Subnets"
    "kubernetes.io/role/elb" = 1    
    "kubernetes.io/cluster/${local.redis_cluster_name}" = "shared"        
  }
  private_subnet_tags = {
    Type = "private-subnets"
    "kubernetes.io/role/internal-elb" = 1    
    "kubernetes.io/cluster/${local.redis_cluster_name}" = "shared"    
  }

  elasticache_subnet_tags = {
    Type = "database-subnets"
  }
}

data "aws_availability_zones" "available" {}


resource "aws_elasticache_subnet_group" "redis" {
  name       = "nimtechnology-cache-subnet"
  subnet_ids = module.vpc.elasticache_subnets
}