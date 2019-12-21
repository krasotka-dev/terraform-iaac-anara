module "my-cluster" {
  source                    = "./terraform-aws-eks"
  cluster_name              = "my-cluster"
  subnets                   = ["subnet-c74d1e8d", "subnet-e4820eb8", "subnet-1fe46778"]
  vpc_id                    = "vpc-1471ad6e"
  cluster_version           = "1.14"
  cluster_security_group_id = "sg-0baae22921460195f"
  manage_aws_auth           = true

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
