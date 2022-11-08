# #
# # Security group resources
# #
resource "aws_security_group" "allow_rdp" {
  vpc_id = module.vpc.vpc_id

  ingress = [
              {
                "cidr_blocks": ["0.0.0.0/0"],
                "description": "",
                "from_port": 3389,
                "ipv6_cidr_blocks": [],
                "prefix_list_ids": [],
                "protocol": "tcp",
                "security_groups": [],
                "self": true,
                "to_port": 3389
              }
            ]
  
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  #https://stackoverflow.com/questions/43980946/define-tags-in-central-section-in-terraform
  tags = merge(
    local.common_tags,
    tomap({
      "Name"      = "sgMSKCluster" ##look into
    })
  )

  # the "map" function was deprecated in Terraform v0.12
  # tags = merge(
  #   local.common_tags,
  #   map(
  #     "Name", "sgCacheCluster",
  #     "Project", var.project,
  #   )
  # )

  lifecycle {
      create_before_destroy = true
  } 

}
