variable "project_name" {
  description = "Project name."
  type        = string
  default     = "eks-auto-scaling-and-strategies-ops"
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

variable "gitops_repo_url" {
  description = "Boostrap git repository"
  type        = string
}

variable "gitops_target_revision" {
  description = "Branch revision used by the Argo CD"
  type        = string
  default     = "main"
}

variable "gitops_root_path" {
  description = "Repository path the Argo CD"
  type        = string
  default     = "gitops/bootstrap"
}
