variable "project_name" {
  description = "Project name."
  type        = string
  default     = "eks-ops"
}

variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
  default     = "eks-ops-cluster"
}

// Singapore
variable "aws_region" {
  description = "AWS region."
  type        = string
  default     = "ap-southeast-1"
}

variable "eks_version" {
  description = "Kubernetes version."
  type        = string
  default     = "1.36" // latest
}

variable "vpc_cidr" {
  description = "CIDR VPC."
  type        = string
  default     = "10.0.0.0/16"
}


variable "argocd_chart_version" {
  description = "Argo CD Helm chart version"
  type        = string
  default     = "10.3.0"
}

variable "cluster_endpoint_public_access_cidrs" {
  description = "Allow whiltelist to access EKS API endpoint"
  type        = list(string)
}
