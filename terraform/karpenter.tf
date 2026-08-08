module "karpenter" {
  source  = "terraform-aws-modules/eks/aws//modules/karpenter"
  version = "21.24.1"

  cluster_name = module.eks.cluster_name
  namespace    = local.karpenter_namespace

  service_account = local.karpenter_service_account

  enable_inline_policy = true

  queue_name                    = local.karpenter_queue_name
  node_iam_role_name            = local.karpenter_node_role_name
  node_iam_role_use_name_prefix = false

  tags = local.common_tags
}
