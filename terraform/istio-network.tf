resource "aws_vpc_security_group_ingress_rule" "istiod_webhook" {
  security_group_id            = module.eks.node_security_group_id
  referenced_security_group_id = module.eks.cluster_security_group_id

  description = "Ingress rule EKS control plane Istiod webhook"
  ip_protocol = "tcp"
  from_port   = 15017
  to_port     = 15017
}