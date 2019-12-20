module "my-cluster" {
  source       = "terraform-aws-modules/eks/aws"
  cluster_name = "dev"
  subnets      = ["subnet-e3a93a85", "subnet-3425477c", "subnet-104d904a"]
  vpc_id       = "vpc-908caaf6"

  worker_groups = [
    {
      instance_type = "m4.large"
      asg_max_size  = 5
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
