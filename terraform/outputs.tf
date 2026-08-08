output "cluster_name" {
  description = "EKS cluster name"
  value       = module.eks.cluster_name
}

output "cluster_endpoint" {
  description = "Kube-apiserver endpoint"
  value       = module.eks.cluster_endpoint
}

output "availability_zones" {
  description = "Availability Zones"
  value       = local.availability_zones
}

output "configure_kubectl_command" {
  description = "Command get kubeconfig file"
  value       = "aws eks update-kubeconfig --region ${var.aws_region} --name ${module.eks.cluster_name}"
}

output "node_security_group_id" {
  description = "security group EKS and Karpenter EC2NodeClass"
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

output "argocd_namespace" {
  description = "Namespace Argo CD"
  value       = local.argocd_namespace
}

output "argocd_port_forward_command" {
  description = "Command forward port to Argo CD UI"
  value       = "kubectl --namespace ${local.argocd_namespace} port-forward service/argocd-server 8080:443"
}

output "argocd_admin_password_command" {
  description = "Command Argo CD administrator password"
  value       = "kubectl --namespace ${local.argocd_namespace} get secret argocd-initial-admin-secret --output jsonpath='{.data.password}' | base64 --decode; echo"
}

output "apply_root_application_command" {
  description = "Init GitOps"
  value       = "kubectl apply -f gitops/bootstrap/root-application.yaml"
}

output "istio_nlb_hostname_command" {
  description = "Command print public NLB hostname for Istio gateway"
  value       = "kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.status.loadBalancer.ingress[0].hostname}'; echo"
}

# output "aws_region" {
#   description = "AWS region"
#   value       = var.aws_region
# }

output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}
