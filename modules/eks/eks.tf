data "aws_availability_zones" "available" {}

locals {
  cluster_name = "${var.environment}"
  worker_groups = "${list(
                  map("instance_type","${var.worker_instance_type}",
                      "asg_desired_capacity", "${var.worker_asg_min_size}",
                      "asg_max_size", "${var.worker_asg_max_size}",
                      "asg_min_size", "${var.worker_asg_min_size}",
                      "subnets", "${join(",", var.worker_subnet_ids)}",
                      "root_volume_size", "${var.root_volume_size}",
                      "key_name", "${var.ssh_aws_keyname}",
                      "public_ip", "${var.worker_public}",
                      "ami_id", "${var.ami_id}"
                      ),
  )}"
  tags = "${var.tags}"
}

resource "random_string" "suffix" {
  length  = 8
  special = false
}

module "eks" {
  source                                       = "modules/eks"
  cluster_name                                 = "${local.cluster_name}"
  cluster_version                              = "${var.kubernetes_version}"
  subnets                                      = ["${var.worker_subnet_ids}"]
  tags                                         = "${local.tags}"
  vpc_id                                       = "${var.vpc_id}"
  worker_groups                                = "${local.worker_groups}"
  worker_group_count                           = "1"
  map_roles                                    = "${var.map_roles}"
  map_users                                    = "${var.map_users}"
  map_accounts                                 = "${var.map_accounts}"
  kubeconfig_aws_authenticator_command         = "aws-iam-authenticator"
  kubeconfig_aws_authenticator_additional_args = "${var.kubeconfig_aws_authenticator_additional_args}"
  config_output_path                           = "./data/"
  allow_cidr_blocks                            = "${var.allow_cidr_blocks}"
  ssh_sg                                       = "${var.sg_ids["vpc_mgmt"]}"
  base_domain                                  = "${var.base_domain}"
  environment                                  = "${var.environment}"
  allow_roles                                  = "${var.allow_roles}"
  new_relic_license                            = "${var.new_relic_license}"
  install_new_relic                            = "${var.install_new_relic}"
  base_domain_zone_id                          = "${var.base_domain_zone_id}"
}
