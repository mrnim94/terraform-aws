# Input Variables
# AWS Region
variable "aws_region" {
  description = "Region in which AWS Resources to be created"
  type = string
  default = "us-east-1"  
}

variable "env" {
  description = "Environment in which AWS Resources to be created"
  type = string
  default = "develop"  
}

variable "family" {
  type = string
  default = "redis5.0"
}

locals {
  name = "nimtechnology"
  common_tags = {
    Component   = "nimtechnology"
    Environment = var.env
  }
  redis_cluster_name = "${local.name}-${var.cluster_name}"  
}

variable "cluster_name" {
  default = "aws-redis"
}

# VPC CIDR Block
variable "vpc_cidr_block" {
  description = "VPC CIDR Block"
  type = string 
  default = "10.0.0.0/16"
}

# VPC Database Subnets
variable "vpc_elasticache_subnets" {
  description = "VPC Redis Subnets"
  type = list(string)
  default = ["10.0.151.0/24", "10.0.152.0/24"]
}

# VPC Create Database Subnet Group (True / False)
variable "vpc_create_elasticache_subnet_group" {
  description = "VPC Create Redis Subnet Group"
  type = bool
  default = true 
}

# VPC Create Database Subnet Route Table (True or False)
variable "vpc_create_elasticache_subnet_route_table" {
  description = "VPC Create Redis Subnet Route Table"
  type = bool
  default = true   
}

# VPC Public Subnets
variable "vpc_public_subnets" {
  description = "VPC Public Subnets"
  type = list(string)
  default = ["10.0.101.0/24", "10.0.102.0/24"]
}

# VPC Private Subnets
variable "vpc_private_subnets" {
  description = "VPC Private Subnets"
  type = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

# VPC Enable NAT Gateway (True or False) 
variable "vpc_enable_nat_gateway" {
  description = "Enable NAT Gateways for Private Subnets Outbound Communication"
  type = bool
  default = true  
}

# VPC Single NAT Gateway (True or False)
variable "vpc_single_nat_gateway" {
  description = "Enable only single NAT Gateway in one Availability Zone to save costs during our demos"
  type = bool
  default = true
}

variable "cache_identifier" {
  default = "redis-cluster-mode-enable-nimtechnology"
}

variable "automatic_failover_enabled" {
  default = true
}

variable "multi_az_enabled" {
  default = true
}

variable "alarm_cpu_threshold" {
  default = "75"
}

variable "desired_clusters" {
  default = "3"
}

variable "instance_type" {
  default = "cache.t2.micro"
}

variable "engine_version" {
  default = "5.0.6"
}

variable "maintenance_window" {
  default = "sun:02:30-sun:03:30"
}

variable "at_rest_encryption_enabled" {
  type        = bool
  default     = true
  description = "Enable encryption at rest"
}

variable "transit_encryption_enabled" {
  type        = bool
  default     = true
  description = <<-EOT
    Set `true` to enable encryption in transit. Forced `true` if `var.auth_token` is set.
    If this is enabled, use the [following guide](https://docs.aws.amazon.com/AmazonElastiCache/latest/red-ug/in-transit-encryption.html#connect-tls) to access redis.
    EOT
}


variable "sns_topic_name" {
  type = string
  default = "Unknown"
}