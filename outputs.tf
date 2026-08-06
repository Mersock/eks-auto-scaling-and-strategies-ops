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
  description = "security group EKS and Karpenter nodes."
  value       = module.eks.node_security_group_id
}
