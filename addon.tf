
################################################################################
# Kubernetes Addons
################################################################################


locals {
  base = {}
  kubescape = {
    kubescapecloudoperator = {
      account : var.kubescape_account_id
      clusterName : var.cluster_name
    }


  }
  values = merge(local.kubescape, local.base)
}

module "kubernetes_addons_default" {
  source = "github.com/aws-ia/terraform-aws-eks-blueprints?ref=v4.28.0/modules/kubernetes-addons"

  eks_cluster_id       = module.eks.cluster_name
  eks_cluster_endpoint = module.eks.cluster_endpoint
  eks_oidc_provider    = module.eks.oidc_provider
  eks_cluster_version  = module.eks.cluster_version

  enable_argocd = true
  # This example shows how to set default ArgoCD Admin Password using SecretsManager with Helm Chart set_sensitive values.
  argocd_helm_config = {
    set_sensitive = [
      {
        name  = "configs.secret.argocdServerAdminPassword"
        value = bcrypt_hash.argo.id
      }
    ]
    version = var.argocd_version
  }

  argocd_manage_add_ons = true # Indicates that ArgoCD is responsible for managing/deploying add-ons
  argocd_applications = {
    addons = {
      path               = "chart"
      repo_url           = "https://github.com/abelnieva/eks-blueprints-add-ons.git"
      add_on_application = true
      values             = local.values
    }
    baseconfig = {
      path               = "./"
      repo_url           = "https://github.com/abelnieva/eks-security-framework-base.git"
      add_on_application = false
    }

    apps = {
      path               = var.repo_apps_path
      repo_url           = var.repo_apps_url
      add_on_application = false
    }

  }

  # Add-ons
  enable_amazon_eks_aws_ebs_csi_driver = false
  enable_aws_for_fluentbit             = true
  # Let fluentbit create the cw log group
  aws_for_fluentbit_create_cw_log_group = false
  enable_cert_manager                   = false
  enable_cluster_autoscaler             = true
  enable_metrics_server                 = true
  enable_prometheus                     = true
  enable_kyverno                        = true
  enable_calico                         = true
  enable_external_dns                   = false
  #eks_cluster_domain = var.dns_zones != [] ? var.dns_zones[0] : ""
  #external_dns_route53_zone_arns = [ for x in var.dns_zones : aws_route53_zone.dns[x].arn ]
  tags = local.tags
}

#---------------------------------------------------------------
# ArgoCD Admin Password credentials with Secrets Manager
# Login to AWS Secrets manager with the same role as Terraform to extract the ArgoCD admin password with the secret name as "argocd"
#---------------------------------------------------------------
resource "random_password" "argocd" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

# Argo requires the password to be bcrypt, we use custom provider of bcrypt,
# as the default bcrypt function generates diff for each terraform plan
resource "bcrypt_hash" "argo" {
  cleartext = random_password.argocd.result
}

#tfsec:ignore:aws-ssm-secret-use-customer-key
resource "aws_secretsmanager_secret" "argocd" {
  name                    = "argocd"
  recovery_window_in_days = 0 # Set to zero for this example to force delete during Terraform destroy
}

resource "aws_secretsmanager_secret_version" "argocd" {
  secret_id     = aws_secretsmanager_secret.argocd.id
  secret_string = random_password.argocd.result
}
