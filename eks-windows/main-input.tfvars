region = "us-east-1"
### Cluster
eks_cluster_name = "sample-cluster-01"
eks_cluster_version = "1.23"

### Linux Nodegroup
lin_desired_size = "2"
lin_max_size = "2"
lin_min_size = "2"
lin_instance_type = "t3.medium"

### Windows Nodegroup
win_desired_size = "2"
win_max_size = "2"
win_min_size = "2"
win_instance_type = "t3.xlarge"

node_host_key_name = "eks-terraform-key"

