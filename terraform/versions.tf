terraform {
  required_version = ">= 1.15, < 2.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.55.0"
    }

    helm = {
      source  = "hashicorp/helm"
      version = "3.2.0"
    }
  }
}
