output "cluster_name" {
  description = "EKS cluster name"
  value       = module.eks.cluster_name
}

output "cluster_endpoint" {
  description = "Kube-apiserver endpoint"
  value       = module.eks.cluster_endpoint
}

output "configure_kubectl_command" {
  description = "Command get kubeconfig file"
  value       = "aws eks update-kubeconfig --region ${var.aws_region} --name ${module.eks.cluster_name}"
}

output "node_security_group_id" {
  description = "security group EKS and Karpenter nodes"
  value       = module.eks.node_security_group_id
}

output "karpenter_controller_role_arn" {
  description = "IAM role for Karpenter controller EKS Pod Identity"
  value       = module.karpenter.iam_role_arn
}

output "karpenter_node_role_name" {
  description = "IAM role for Karpenter EC2NodeClass use for provisioned nodes"
  value       = module.karpenter.node_iam_role_name
}

output "karpenter_interruption_queue_name" {
  description = "SQS queue name for Karpenter events"
  value       = module.karpenter.queue_name
}

output "aws_load_balancer_controller_role_arn" {
  description = "IAM role AWS Load Balancer Controller in EKS Pod Identity"
  value       = aws_iam_role.aws_load_balancer_controller.arn
}

output "nlb_dns_name" {
  description = "DNS public Network Load Balancer"
  value       = aws_lb.aws_lb_eks.dns_name
}

output "application_url" {
  description = "HTTP URL application"
  value       = "http://${aws_lb.aws_lb_eks.dns_name}"
}

output "target_group_arn" {
  description = "Target group arn Argo CD"
  value       = aws_lb_target_group.eks_pod_apps.arn
}

output "argocd_public_url_command" {
  description = "Command public Argo CD URL from NLB"
  value       = "echo http://$(kubectl --namespace ${local.argocd_namespace} get service argocd-server-public --output jsonpath='{.status.loadBalancer.ingress[0].hostname}')"
}

output "argocd_admin_password_command" {
  description = "Command Argo CD administrator password"
  value       = "kubectl --namespace ${local.argocd_namespace} get secret argocd-initial-admin-secret --output jsonpath='{.data.password}' | base64 --decode; echo"
}