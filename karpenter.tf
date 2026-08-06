module "karpenter" {
  source  = "terraform-aws-modules/eks/aws//modules/karpenter"
  version = "21.24.1"

  cluster_name = module.eks.cluster_name
  namespace    = local.karpenter_namespace
  enable_inline_policy = true

  tags = local.common_tags
}
