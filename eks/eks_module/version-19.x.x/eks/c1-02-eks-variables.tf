variable "aws_region" {
  description = "Please enter the region used to deploy this infrastructure"
  type        = string
  default = "us-west-2"  
}

# Environment Variable
variable "environment" {
  description = "Environment Variable used as a prefix"
  type = string
  default = "dev"
}

# Business Division
variable "business_divsion" {
  description = "Business Division in the large organization this Infrastructure belongs"
  type = string
  default = "nimtechnology"
}

variable "eks_cluster_version" {
  description = "Please enter the EKS cluster version"
  type        = string
  default = "1.23"
}

variable "eks_cluster_name" {
  description = "Please enter an EKS cluster name"
  type        = string
  default = "nimtechnology-devops"
}

variable "owners" {
  description = "Please enter an owners name that control eks cluster"
  type        = string
  default = "devops"
}

variable "lin_instance_type" {
  description = "Please enter the instance type to be used for the Linux worker nodes"
  type        = string
  default = "t3.large"
}

variable "lin_min_size" {
  description = "Please enter the minimal size for the Linux ASG"
  type        = string
  default = "1"
}
variable "lin_max_size" {
  description = "Please enter the maximal size for the Linux ASG"
  type        = string
  default = "1"
}
variable "lin_desired_size" {
  description = "Please enter the desired size for the Linux ASG"
  type        = string
  default = "1"
}

variable "node_host_key_name" {
  description = "Please enter the name of the SSH key pair that should be assigned to the worker nodes of the cluster"
  type        = string
  default = "devops"
}