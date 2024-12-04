module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "~> 20.0"  
  cluster_name    = "wordpress-cluster"
  cluster_version = "1.27"
  vpc_id          = aws_vpc.main.id
  subnet_ids      = aws_subnet.public[*].id

  eks_managed_node_groups = {
    wordpress-nodes = {
      desired_capacity = 2
      max_capacity     = 5
      min_capacity     = 1

      instance_types = ["t3.medium"]
    }
  }
}

