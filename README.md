# terraform-aws-eks-security-clusters


## Project Overwiew

This terraform module is part of the terraform eks security framework

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.47 |
| <a name="requirement_bcrypt"></a> [bcrypt](#requirement\_bcrypt) | >= 0.1.2 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | >= 2.8 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.17 |
| <a name="requirement_random"></a> [random](#requirement\_random) | 3.3.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.67.0 |
| <a name="provider_bcrypt"></a> [bcrypt](#provider\_bcrypt) | 0.1.2 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.3.2 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ecr"></a> [ecr](#module\_ecr) | terraform-aws-modules/ecr/aws | 1.6.0 |
| <a name="module_eks"></a> [eks](#module\_eks) | terraform-aws-modules/eks/aws | ~> 19.12 |
| <a name="module_eks_blueprints_admin_team"></a> [eks\_blueprints\_admin\_team](#module\_eks\_blueprints\_admin\_team) | aws-ia/eks-blueprints-teams/aws | ~> 0.2 |
| <a name="module_eks_blueprints_dev_teams"></a> [eks\_blueprints\_dev\_teams](#module\_eks\_blueprints\_dev\_teams) | aws-ia/eks-blueprints-teams/aws | ~> 0.2 |
| <a name="module_kubernetes_addons_default"></a> [kubernetes\_addons\_default](#module\_kubernetes\_addons\_default) | github.com/aws-ia/terraform-aws-eks-blueprints | v4.28.0/modules/kubernetes-addons |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-aws-modules/vpc/aws | ~> 4.0 |
| <a name="module_vpc_endpoints"></a> [vpc\_endpoints](#module\_vpc\_endpoints) | terraform-aws-modules/vpc/aws//modules/vpc-endpoints | ~> 4.0 |
| <a name="module_vpc_endpoints_sg"></a> [vpc\_endpoints\_sg](#module\_vpc\_endpoints\_sg) | terraform-aws-modules/security-group/aws | ~> 4.0 |

## Resources

| Name | Type |
|------|------|
| [aws_instance.agent](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_key_pair.key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair) | resource |
| [aws_route53_zone.dns](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_zone) | resource |
| [aws_secretsmanager_secret.argocd](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) | resource |
| [aws_secretsmanager_secret_version.argocd](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_version) | resource |
| [aws_security_group.tf_agent](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [bcrypt_hash.argo](https://registry.terraform.io/providers/viktorradnai/bcrypt/latest/docs/resources/hash) | resource |
| [random_password.argocd](https://registry.terraform.io/providers/hashicorp/random/3.3.2/docs/resources/password) | resource |
| [aws_ami.tfagent](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_eks_cluster_auth.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster_auth) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_argocd_version"></a> [argocd\_version](#input\_argocd\_version) | default argocd helm chart version | `string` | `"5.19.14"` | no |
| <a name="input_cluster_enabled_log_types"></a> [cluster\_enabled\_log\_types](#input\_cluster\_enabled\_log\_types) | A list of the desired control plane logging to enable | `list(string)` | <pre>[<br>  "api",<br>  "audit",<br>  "authenticator",<br>  "controllerManager",<br>  "scheduler"<br>]</pre> | no |
| <a name="input_cluster_endpoint_private_access"></a> [cluster\_endpoint\_private\_access](#input\_cluster\_endpoint\_private\_access) | Indicates whether or not the EKS private API server endpoint is enabled. Default to EKS resource and it is false | `bool` | `true` | no |
| <a name="input_cluster_endpoint_public_access"></a> [cluster\_endpoint\_public\_access](#input\_cluster\_endpoint\_public\_access) | Indicates whether or not the EKS public API server endpoint is enabled. Default to EKS resource and it is true | `bool` | `false` | no |
| <a name="input_cluster_endpoint_public_access_cidrs"></a> [cluster\_endpoint\_public\_access\_cidrs](#input\_cluster\_endpoint\_public\_access\_cidrs) | List of CIDR blocks which can access the Amazon EKS public API server endpoint | `list(string)` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Cluster Name | `string` | n/a | yes |
| <a name="input_cluster_security_group_additional_rules"></a> [cluster\_security\_group\_additional\_rules](#input\_cluster\_security\_group\_additional\_rules) | List of additional security group rules to add to the cluster security group created. Set `source_node_security_group = true` inside rules to set the `node_security_group` as source | `any` | `{}` | no |
| <a name="input_cluster_version"></a> [cluster\_version](#input\_cluster\_version) | Kubernetes `<major>.<minor>` version to use for the EKS cluster (i.e.: `1.23`) | `string` | `"1.23"` | no |
| <a name="input_dev_teams"></a> [dev\_teams](#input\_dev\_teams) | dev teams | `map(any)` | `{}` | no |
| <a name="input_dns_zones"></a> [dns\_zones](#input\_dns\_zones) | list of dns zones to be managed by cluster | `list(any)` | `[]` | no |
| <a name="input_ecr_repos_list"></a> [ecr\_repos\_list](#input\_ecr\_repos\_list) | Path en el repositorio de configuración base | `list(any)` | `[]` | no |
| <a name="input_kubescape_account_id"></a> [kubescape\_account\_id](#input\_kubescape\_account\_id) | kubescape account ID | `string` | `""` | no |
| <a name="input_managed_node_groups"></a> [managed\_node\_groups](#input\_managed\_node\_groups) | Node groups configuration<br>example<br>  {<br>    node\_group\_b = {}<br>    node\_group\_a = {<br>      min\_size     = 1<br>      max\_size     = 10<br>      desired\_size = 1<br><br>      instance\_types = ["t3.large"]<br>      capacity\_type  = "SPOT"<br><br>      update\_config = {<br>        max\_unavailable\_percentage = 33 # or set `max_unavailable`<br>      }<br><br>      tags = {<br>        ExtraTag = "example"<br>      }<br>    }<br>  } | `map(any)` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | AWS region | `string` | `"us-east-1"` | no |
| <a name="input_repo_addons_url"></a> [repo\_addons\_url](#input\_repo\_addons\_url) | Repositorio de configuración de addons | `string` | `"https://github.com/abelnieva/eks-blueprints-add-ons.git"` | no |
| <a name="input_repo_apps_path"></a> [repo\_apps\_path](#input\_repo\_apps\_path) | Path en el repositorio de las aplicaciones | `string` | `"./"` | no |
| <a name="input_repo_apps_url"></a> [repo\_apps\_url](#input\_repo\_apps\_url) | Repositorio de las aplicaciones | `string` | `"https://github.com/abelnieva/eks-security-framework-apps.git"` | no |
| <a name="input_repo_base_path"></a> [repo\_base\_path](#input\_repo\_base\_path) | Path en el repositorio de configuración base | `string` | `"./"` | no |
| <a name="input_repo_base_url"></a> [repo\_base\_url](#input\_repo\_base\_url) | Repositorio de configuración base dirección web | `string` | `"https://github.com/abelnieva/eks-security-framework-base.git"` | no |
| <a name="input_ssh_public_key"></a> [ssh\_public\_key](#input\_ssh\_public\_key) | ssh public key | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | default tags | `map(any)` | `{}` | no |
| <a name="input_tfc_agent_instance_type"></a> [tfc\_agent\_instance\_type](#input\_tfc\_agent\_instance\_type) | Default ec2 instance type for terraform cloud | `string` | `"t3.large"` | no |
| <a name="input_tfc_agent_name"></a> [tfc\_agent\_name](#input\_tfc\_agent\_name) | Default Terraform cloud agent to be installed in your account | `string` | `"agent"` | no |
| <a name="input_tfc_agent_token"></a> [tfc\_agent\_token](#input\_tfc\_agent\_token) | Token to access to your terraform cloud account | `string` | `""` | no |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | VPC CIDR, this parameter is needed to create the VPC | `string` | n/a | yes |
| <a name="input_vpc_endpoints_list"></a> [vpc\_endpoints\_list](#input\_vpc\_endpoints\_list) | VPC's Private Endpoints to be created | `list(string)` | <pre>[<br>  "autoscaling",<br>  "ecr.api",<br>  "ecr.dkr",<br>  "ec2",<br>  "ec2messages",<br>  "elasticloadbalancing",<br>  "sts",<br>  "kms",<br>  "logs",<br>  "ssm",<br>  "ssmmessages"<br>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_id"></a> [cluster\_id](#output\_cluster\_id) | The ID of the EKS Cluster |
| <a name="output_configure_kubectl"></a> [configure\_kubectl](#output\_configure\_kubectl) | Configure kubectl: make sure you're logged in with the correct AWS profile and run the following command to update your kubeconfig |
