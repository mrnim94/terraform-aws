resource "aws_sns_topic" "redis" {
  name = var.sns_topic_name
  
}

# #https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_parameter_group
resource "aws_elasticache_parameter_group" "redis" {
  name   = "cache-params"
  family = var.family

  parameter {
    name  = "activerehashing"
    value = "yes"
  }
  parameter {
    name  = "notify-keyspace-events"
    value = "KEA"
  }
}

# #
# # ElastiCache resources
# #
resource "aws_elasticache_replication_group" "redis_mdaas" {
  replication_group_id          = lower(var.cache_identifier)
  description = "${var.env}-nimtechnology"
  automatic_failover_enabled    = var.automatic_failover_enabled
  multi_az_enabled              = var.multi_az_enabled
  #availability_zones            =  var.availability_zones == [] ? null : var.availability_zones
#   preferred_cache_cluster_azs  = module.vpc.azs

  num_cache_clusters         = var.desired_clusters
  node_type                     = var.instance_type
  engine_version                = var.engine_version
  parameter_group_name          = aws_elasticache_parameter_group.redis.name
  subnet_group_name             = aws_elasticache_subnet_group.redis.name
  security_group_ids            = [aws_security_group.redis.id]
  maintenance_window            = var.maintenance_window
  notification_topic_arn        = aws_sns_topic.redis.arn
  port                          = "6379"

  # cluster_mode {
  #   replicas_per_node_group = 1
  #   num_node_groups         = 2
  # }

  at_rest_encryption_enabled    = var.at_rest_encryption_enabled
  transit_encryption_enabled    = var.transit_encryption_enabled

  tags = merge(
    local.common_tags,
    tomap({
      "Name"    = "CacheReplicationGroup"
    })
  )

}