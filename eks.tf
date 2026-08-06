module "eks" {
  depends_on = [module.vpc]
  source  = "terraform-aws-modules/eks/aws"
  version = "21.24.1"

  name               = local.cluster_name
  kubernetes_version = var.eks_version

  endpoint_public_access = true

  enable_cluster_creator_admin_permissions = true

  // only uses EKS Pod Identity and no requires OpenID Connect Provider IRSA
  enable_irsa = false

  // disabled customer managed KMS key
  create_kms_key    = false
  encryption_config = null

  addons = {
    coredns = {}

    eks-pod-identity-agent = {
      before_compute = true
    }

    kube-proxy = {}

    vpc-cni = {
      before_compute = true
    }
  }

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  node_security_group_tags = {
    "karpenter.sh/discovery" = local.cluster_name
  }

  // on-demand system manag node group
  eks_managed_node_groups = {
    system = {
      capacity_type  = "ON_DEMAND"
      instance_types = local.system_node_group.instance_types

      min_size     = local.system_node_group.min_size
      desired_size = local.system_node_group.desired_size
      max_size     = local.system_node_group.max_size

      labels = {
        workload-tier = "system"
      }
    }
  }
}
