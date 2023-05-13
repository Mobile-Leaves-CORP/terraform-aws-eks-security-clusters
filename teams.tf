



module "eks_blueprints_admin_team" {
  source  = "aws-ia/eks-blueprints-teams/aws"
  version = "~> 0.2"

  name = "admin-team"

  enable_admin = true
  users        = [data.aws_caller_identity.current.arn, "arn:aws:iam::481020473208:root"]
  cluster_arn  = module.eks.cluster_arn

  tags = local.tags
}


module "eks_blueprints_dev_teams" {
  source   = "aws-ia/eks-blueprints-teams/aws"
  version  = "~> 0.2"
  for_each = var.dev_teams
  name     = "${each.key}-team"

  users             = each.value.users
  cluster_arn       = module.eks.cluster_arn
  oidc_provider_arn = module.eks.oidc_provider

  # Lables applied to all Kubernetes resources
  # More specific labels can be applied to individual resources under `namespaces` below
  labels = {
    team = each.key
  }


  namespaces = each.value.namespaces


  tags = local.tags
}
