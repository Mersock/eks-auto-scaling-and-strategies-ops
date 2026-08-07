resource "helm_release" "argocd" {
  name             = "argocd"
  namespace        = local.argocd_namespace
  create_namespace = true

  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = var.argocd_chart_version

  depends_on = [module.eks]

  // use http only 
  values = [
    yamlencode({
      configs = {
        params = {
          "server.insecure" = true
        }
      }
    })
  ]
}

resource "helm_release" "argocd_root_application" {
  name      = "argocd-root-application"
  namespace = local.argocd_namespace
  chart     = "${path.module}/bootstrap/root-application"

  values = [
    yamlencode({
      rootApplication = {
        name                 = "root"
        namespace            = local.argocd_namespace
        repoURL              = var.gitops_repo_url
        targetRevision       = var.gitops_target_revision
        path                 = var.gitops_root_path
        destinationServer    = "https://kubernetes.default.svc"
        destinationNamespace = local.argocd_namespace
      }

      gitopsValues = {
        gitops = {
          repoURL        = var.gitops_repo_url
          targetRevision = var.gitops_target_revision
        }
      
        global = {
          awsRegion      = var.aws_region
          clusterName    = module.eks.cluster_name
          vpcId          = module.vpc.vpc_id
          targetGroupArn = aws_lb_target_group.eks_pod_apps.arn

          karpenter = {
            interruptionQueueName = module.karpenter.queue_name
          }
        }
      }
    })
  ]

  wait = false

  depends_on = [helm_release.argocd]
}
