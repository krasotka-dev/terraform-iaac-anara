variable "region" {
  default = "us-east-1"
}

variable "ami_id" {
  description = "AMI ID for the eks workers. If none is provided, the included module uses Terraform to search for the latest version of the AWS EKS optimized worker AMI."
  default     = ""
}

variable "map_accounts" {
  description = "Additional AWS account numbers to add to the aws-auth configmap."
  type        = list

  default = []
}

variable "map_roles" {
  description = "Additional IAM roles to add to the aws-auth configmap."
  type        = list

  default = []
}

variable "map_users" {
  description = "Additional IAM users to add to the aws-auth configmap."
  type        = list

  default = []
}

variable "vpc_id" {}

variable "allow_cidr_blocks" {
  type = list
}

variable "base_domain" {}
variable "base_domain_zone_id" {}

variable "sg_ids" {
  type = map
}

variable "environment" {}

variable "worker_instance_type" {}

variable "worker_subnet_ids" {
  type = list
}

variable "worker_asg_min_size" {}

variable "worker_asg_max_size" {}

variable "tags" {
  type = map
}

variable "root_volume_size" {
  default = "100"
}

variable "worker_public" {
  default = false
}

variable "ssh_aws_keyname" {}

variable "kubeconfig_aws_authenticator_additional_args" {
  type    = list
  default = []
}

variable "allow_roles" {
  type    = list
  default = []
}

variable "kubernetes_version" {}

variable "new_relic_license" {
  default = ""
}
variable "install_new_relic" {
  description = "string bool flag to install new relic infra agent on eks nodes"
  default = "false"
}
variable "ssh_public_key" {}
variable "s3_bucket" {}
