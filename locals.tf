locals {

  region   = var.region
  vpc_cidr = var.vpc_cidr
  azs      = slice(data.aws_availability_zones.available.names, 0, 3)

  tags = var.tags
  cluster_security_group_additional_rules_base = {
    ingress_cluster_all = {
      description              = "Traffic from terraform cloud agent"
      protocol                 = "HTTPS"
      from_port                = 443
      to_port                  = 443
      type                     = "ingress"
      source_security_group_id = aws_security_group.tf_agent.id
    }
  }
}
