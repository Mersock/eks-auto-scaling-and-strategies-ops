resource "aws_security_group" "nlb" {
  name        = "${var.project_name}-nlb"
  description = "SG for public NLB"
  vpc_id      = module.vpc.vpc_id
}

resource "aws_vpc_security_group_ingress_rule" "nlb_http" {
  security_group_id = aws_security_group.nlb.id

  description = "allow public HTTP traffic port 80"
  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "tcp"
  from_port   = 80
  to_port     = 80
}

resource "aws_vpc_security_group_egress_rule" "nlb_to_nodes" {
  security_group_id = aws_security_group.nlb.id

  description                  = "allow NLB traffic to EKS pods"
  referenced_security_group_id = module.eks.node_security_group_id
  ip_protocol                  = "tcp"
  from_port                    = 80
  to_port                      = 80
}

resource "aws_vpc_security_group_ingress_rule" "nodes_from_nlb" {
  security_group_id = module.eks.node_security_group_id

  description                  = "allow NLB traffic and health checks"
  referenced_security_group_id = aws_security_group.nlb.id
  ip_protocol                  = "tcp"
  from_port                    = 80
  to_port                      = 80
}

resource "aws_lb" "aws_lb_eks" {
  name               = "${var.project_name}-nlb"
  internal           = false
  load_balancer_type = "network"
  security_groups    = [aws_security_group.nlb.id]
  subnets            = module.vpc.public_subnets

  enable_cross_zone_load_balancing = true
}

resource "aws_lb_target_group" "eks_pod_apps" {
  name        = "${var.project_name}-eks-pod-apps"
  port        = 80
  protocol    = "TCP"
  target_type = "ip"
  vpc_id      = module.vpc.vpc_id

  health_check {
    protocol            = "HTTP"
    port                = "traffic-port"
    path                = "/"
    matcher             = "200-399"
    interval            = 10
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.aws_lb_eks.arn
  port              = 80
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.eks_pod_apps.arn
  }
}
