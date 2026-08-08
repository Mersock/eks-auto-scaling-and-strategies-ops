resource "helm_release" "argocd" {
  name             = "argocd"
  namespace        = local.argocd_namespace
  create_namespace = true

  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = var.argocd_chart_version

  values = [
    file("${path.module}/../gitops/bootstrap/argocd-values.yaml")
  ]

  depends_on = [module.eks]
}
