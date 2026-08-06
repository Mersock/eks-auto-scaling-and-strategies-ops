locals {
  cluster_name = "${var.project_name}-cluster"

  // 2 AZ
  availability_zones = slice(data.aws_availability_zones.available.names, 0, 2)

  public_subnet_cidrs = [
    cidrsubnet(var.vpc_cidr, 8, 0),
    cidrsubnet(var.vpc_cidr, 8, 1),
  ]

  private_subnet_cidrs = [
    cidrsubnet(var.vpc_cidr, 8, 10),
    cidrsubnet(var.vpc_cidr, 8, 11),
  ]

  // low size for demo only
  system_node_group = {
    instance_types = ["t3.medium"]
    min_size       = 1
    desired_size   = 2
    max_size       = 2
  }

  argocd_namespace = "argocd"

  karpenter_namespace       = "karpenter"
  karpenter_service_account = "karpenter-sa"

  aws_load_balancer_controller_namespace       = "kube-system"
  aws_load_balancer_controller_service_account = "aws-load-balancer-controller-sa"

  common_tags = {
    Project    = var.project_name
    MaintainerName = "Mersock"
    ManagedBy  = "terraform"
  }
}
