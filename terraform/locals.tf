locals {
  cluster_name = var.cluster_name

  // 3 AZ
  availability_zones = slice(data.aws_availability_zones.available.names, 0, 3)

  public_subnet_cidrs = [
    cidrsubnet(var.vpc_cidr, 8, 0),
    cidrsubnet(var.vpc_cidr, 8, 1),
    cidrsubnet(var.vpc_cidr, 8, 2),
  ]

  private_subnet_cidrs = [
    cidrsubnet(var.vpc_cidr, 8, 10),
    cidrsubnet(var.vpc_cidr, 8, 11),
    cidrsubnet(var.vpc_cidr, 8, 12),
  ]

  // low size for demo only
  system_node_group = {
    // instance_types = ["t3.large"]
    instance_types = ["t3.medium"]
    min_size       = 3
    desired_size   = 3
    max_size       = 3
  }

  argocd_namespace = "argocd"

  karpenter_namespace       = "karpenter"
  karpenter_service_account = "karpenter-sa"
  karpenter_queue_name      = "${local.cluster_name}-karpenter"
  karpenter_node_role_name  = "KarpenterNodeRole-${local.cluster_name}"

  aws_load_balancer_controller_namespace       = "kube-system"
  aws_load_balancer_controller_service_account = "aws-load-balancer-controller-sa"

  common_tags = {
    Project        = var.project_name
    MaintainerName = "Mersock"
    ManagedBy      = "terraform"
  }
}
