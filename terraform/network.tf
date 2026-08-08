module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "6.6.1"

  name = "${var.project_name}-vpc"
  cidr = var.vpc_cidr

  azs             = local.availability_zones
  public_subnets  = local.public_subnet_cidrs
  private_subnets = local.private_subnet_cidrs

  enable_dns_hostnames = true

  // only 1 nat gateway
  enable_nat_gateway = true
  single_nat_gateway = true

  public_subnet_tags = {
    "kubernetes.io/role/elb" = "1"
  }

  private_subnet_tags = {
    "karpenter.sh/discovery" = local.cluster_name
    "Network"                = "private"
  }

  tags = local.common_tags
}

resource "terraform_data" "private_subnets_ready" {
  input = module.vpc.private_subnets

  depends_on = [module.vpc]
}
