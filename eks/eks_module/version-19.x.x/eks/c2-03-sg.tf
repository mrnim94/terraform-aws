# resource "aws_security_group" "eks" {
#   name        = "${var.environment} eks cluster (nim)"
#   description = "Allow outbound traffic for any pods in ${local.cluster_name}"
#   vpc_id      = data.terraform_remote_state.eks.outputs.vpc_id

#   egress {
#     from_port        = 0
#     to_port          = 0
#     protocol         = "-1"
#     cidr_blocks      = ["0.0.0.0/0"]
#     ipv6_cidr_blocks = ["::/0"]
#   }

#   tags = merge({
#     Name = "${local.cluster_name} EKS ${var.environment}",
#     "kubernetes.io/cluster/${local.cluster_name}": "owned"
#   })
# }