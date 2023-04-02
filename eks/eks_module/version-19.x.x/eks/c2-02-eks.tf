#### Nodegroups - Images

data "aws_ami" "lin_ami" {
    most_recent = true
    owners = ["amazon"]
    filter {
        name = "name"
        values = ["amazon-eks-node-${var.eks_cluster_version}-*"]
    }
}

## eks module need this configuration
resource "aws_kms_key" "eks" {
  description = "EKS Encryption Key"
}

module "eks" {
  source       = "terraform-aws-modules/eks/aws"
  # version = "18.30.2"
  version = "~> 19.0"

  cluster_name = local.cluster_name
  cluster_version = var.eks_cluster_version

  vpc_id = data.terraform_remote_state.eks.outputs.vpc_id
  subnet_ids = data.terraform_remote_state.eks.outputs.public_subnets

  enable_irsa = true

  cluster_enabled_log_types       = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = true

  # Extend node-to-node security group rules
  # node_security_group_ntp_ipv4_cidr_block = ["169.254.169.123/32"] is default on version 19.x
  node_security_group_additional_rules = {
    # ingress_self_all = {
    #   description = "Node to node all ports/protocols"
    #   protocol    = "-1"
    #   from_port   = 0
    #   to_port     = 0
    #   type        = "ingress"
    #   self        = true
    # }

    # egress_all = {
    #   description      = "Node all egress"
    #   protocol         = "-1"
    #   from_port        = 0
    #   to_port          = 0
    #   type             = "egress"
    #   cidr_blocks      = ["0.0.0.0/0"]
    #   ipv6_cidr_blocks = ["::/0"]
    # }

    # ingress_cluster_metricserver = {
    #   description                   = "Cluster to node 4443 (Metrics Server)"
    #   protocol                      = "tcp"
    #   from_port                     = 4443
    #   to_port                       = 4443
    #   type                          = "ingress"
    #   source_cluster_security_group = true 
    # }
    # #https://github.com/kubernetes-sigs/metrics-server/issues/448
  }

  # node_security_group_enable_recommended_rules = false
  
  cluster_encryption_config = {
      provider_key_arn = aws_kms_key.eks.arn
      resources        = ["secrets"]
  }

  ### Allow SSM access for Nodes
  self_managed_node_group_defaults = {
    iam_role_additional_policies = ["arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"]
  }

  eks_managed_node_group_defaults = {
    disk_size = 100
    # vpc_security_group_ids = [aws_security_group.eks.id]
  }

  eks_managed_node_groups = {
    "general-${var.owners}" = {
      desired_size = 3
      min_size     = 2
      max_size     = 10

      block_device_mappings = {
        xvda = {
          device_name = "/dev/xvda"
          ebs = {
            volume_size           = 100
            volume_type           = "gp3"
            iops                  = 3000
            throughput            = 125
            encrypted             = true
            delete_on_termination = true
          }
        }
      }

      labels = {
        role = "general"
      }

      instance_types = ["t3.medium"]
      capacity_type  = "ON_DEMAND"
    }

    # "spot-${var.owners}" = {
    #   desired_size = 0
    #   min_size     = 0
    #   max_size     = 10

    #   labels = {
    #     role = "spot"
    #   }

    #   taints = [{
    #     key    = "market"
    #     value  = "spot"
    #     effect = "NO_SCHEDULE"
    #   }]

    #   instance_types = ["t3.micro"]
    #   capacity_type  = "SPOT"
    # }
  }

  # create_cloudwatch_log_group = false


  tags = {
    Name = "${var.eks_cluster_name}"
  }
}

