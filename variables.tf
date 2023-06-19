variable "managed_node_groups" {
  type        = map(any)
  description = <<EOF
Node groups configuration
example
  {
    node_group_b = {}
    node_group_a = {
      min_size     = 1
      max_size     = 10
      desired_size = 1

      instance_types = ["t3.large"]
      capacity_type  = "SPOT"

      update_config = {
        max_unavailable_percentage = 33 # or set `max_unavailable`
      }

      tags = {
        ExtraTag = "example"
      }
    }
  }
EOF


}



/* variable "github_repo" {
  type        = string
  description = "Git repo url"
  default     = "https://github.com/abelnieva/eks-security-framework"
} */

variable "cluster_name" {
  type        = string
  description = "Cluster Name"
}
variable "cluster_version" {
  description = "Kubernetes `<major>.<minor>` version to use for the EKS cluster (i.e.: `1.23`)"
  type        = string
  default     = "1.23"
}

variable "region" {
  type        = string
  description = "AWS region"
  default     = "us-east-1"
}

#-------------------------------
# EKS Cluster Security Groups
#-------------------------------
variable "cluster_security_group_additional_rules" {
  description = "List of additional security group rules to add to the cluster security group created. Set `source_node_security_group = true` inside rules to set the `node_security_group` as source"
  type        = any
  default     = {}
}


variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR, this parameter is needed to create the VPC"
}


variable "vpc_endpoints_list" {
  default     = ["autoscaling", "ecr.api", "ecr.dkr", "ec2", "ec2messages", "elasticloadbalancing", "sts", "kms", "logs", "ssm", "ssmmessages"]
  type        = list(string)
  description = "VPC's Private Endpoints to be created"
}
variable "cluster_endpoint_public_access" {
  type        = bool
  description = "Indicates whether or not the EKS public API server endpoint is enabled. Default to EKS resource and it is true"
  default     = false
}

variable "cluster_endpoint_private_access" {
  type        = bool
  description = "Indicates whether or not the EKS private API server endpoint is enabled. Default to EKS resource and it is false"
  default     = true
}


variable "cluster_endpoint_public_access_cidrs" {
  description = "List of CIDR blocks which can access the Amazon EKS public API server endpoint"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}
variable "cluster_enabled_log_types" {
  type        = list(string)
  description = "A list of the desired control plane logging to enable"
  default     = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
}

variable "tags" {
  description = "default tags"
  type        = map(any)
  default     = {}
}



variable "dev_teams" {
  description = "dev teams"
  type        = map(any)
  default     = {}
}


variable "repo_apps_url_dev" {
  description = "Repositorio de las aplicaciones "
  type        = string
  default     = "https://github.com/abelnieva/eks-security-framework-apps.git"
}

variable "repo_apps_path_dev" {
  description = "Path en el repositorio de las aplicaciones "
  type        = string
  default     = "./main/envs/dev"

}

variable "repo_apps_url_prod" {
  description = "Repositorio de las aplicaciones "
  type        = string
  default     = "https://github.com/abelnieva/eks-security-framework-apps.git"
}

variable "repo_apps_path_prod" {
  description = "Path en el repositorio de las aplicaciones "
  type        = string
  default     = "./main/envs/prod"

}

variable "repo_base_url" {
  description = "Repositorio de configuración base dirección web "
  type        = string
  default     = "https://github.com/abelnieva/eks-security-framework-base.git"
}

variable "repo_base_path" {
  description = "Path en el repositorio de configuración base"
  type        = string
  default     = "./"

}

variable "ecr_repos_list" {
  description = "Path en el repositorio de configuración base"
  type        = list(any)
  default     = []

}

variable "repo_addons_url" {
  description = "Repositorio de configuración de addons"
  type        = string
  default     = "https://github.com/abelnieva/eks-security-framework-add-ons.git"
}



variable "dns_zones" {
  description = "list of dns zones to be managed by cluster"
  type        = list(any)
  default     = []
}


variable "kubescape_account_id" {
  description = "kubescape account ID"
  type        = string
  default     = ""
}

variable "argocd_version" {
  default     = "5.19.14"
  type        = string
  description = "default argocd helm chart version"
}

variable "tfc_agent_token" {
  default     = ""
  type        = string
  description = "Token to access to your terraform cloud account"
}


variable "tfc_agent_name" {
  default     = "agent"
  type        = string
  description = "Default Terraform cloud agent to be installed in your account"
}

variable "tfc_agent_instance_type" {
  default     = "t3.large"
  type        = string
  description = "Default ec2 instance type for terraform cloud"
}

variable "ssh_public_key" {
  default     = ""
  type        = string
  description = "ssh public key"
}
