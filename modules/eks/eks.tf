data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.cluster.token
  load_config_file       = false
  version                = "~> 1.9"
}

module "my-cluster" {
  source                    = "./terraform-aws-eks"
  cluster_name              = "dev"
  subnets                   = ["subnet-c74d1e8d", "subnet-e4820eb8", "subnet-1fe46778"]
  vpc_id                    = "vpc-1471ad6e"
  cluster_version           = "1.14"
  cluster_security_group_id = "sg-0baae22921460195f"

  worker_groups = [{
    instance_type        = "m4.large"
    asg_max_size         = 15
    asg_min_size         = 3
    asg_desired_capacity = 3
    key_name             = "farrukh's_laptop"
    tags = [{
      key                 = "foo"
      value               = "bar"
      propagate_at_launch = true
    }]
    }
  ]

  tags = {
    environment = "test"
  }
}
