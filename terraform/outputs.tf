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

