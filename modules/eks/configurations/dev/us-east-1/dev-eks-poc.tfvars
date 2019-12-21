#####
# Note: Make sure to pay close attention to update the below variables
# They are also used to derive the s3 folder location where terraform state is stored as well as kops state
# The state file will be stored at:
# s3://${s3_bucket}/${s3_folder_project}/${s3_folder_region}/${s3_folder_type}/${environment}/${s3_tfstate_file}
#####
environment       = "dev-eks-poc"
s3_bucket         = "dev-eks-pos-farrukh" #Will be used to set backend.tf
s3_folder_project = "vet" #Will be used to set backend.tf
s3_folder_region  = "us-east-1" #Will be used to set backend.tf
s3_folder_type    = "sharedtools" #Will be used to set backend.tf
s3_tfstate_file   = "infrastructure.tfstate" #Will be used to set backend.tf

# Find out the parent hosted zone by running the below command
# aws route53 list-hosted-zones | jq '.HostedZones[] | select(.Name=="rndecp.net.") | .Id'
base_domain         = "acirrustech.com"
base_domain_zone_id = "Z32OHGRMBVZ9LR"

#existing vpc id mapping
vpc_id = "vpc-1471ad6e"

# existing security group id mappings
sg_ids = {
  vpc_mgmt = "sg-0baae22921460195f"
}

worker_subnet_ids = [
  "subnet-c74d1e8d", #us-east-1a
  "subnet-e4820eb8", #us-east-1b
  "subnet-1fe46778", #us-east-1c
]

worker_public        = false

worker_instance_type = "m4.xlarge"
worker_asg_min_size  = 3
worker_asg_max_size  = 3

# CIDR blocks that should be able to ssh
allow_cidr_blocks = [
  "0.0.0.0/0"
]

#existing ssh key name (for use with logging into instances)
ssh_aws_keyname = "eks_key"
#must be the *public* SSH key to match the ssh_aws_keyname above
ssh_public_key = "~/.ssh/id_rsa.pub"

ami_id = "ami-087a82f6b78a07557"

kubernetes_version = "1.14"

### Input values for common tagging module - see the resource-tagging module in VETTM repo for more information

tags = {
  Environment        = "DEV"
  Cluster            = "DEV-EKS-POC"
}

map_roles = [
  {
    role_arn = "arn:aws:iam::713287746880:role/DevSecOpsAdminRole"
    username = "role1"
    group    = "system:masters"
  },
]

allow_roles = [
  "arn:aws:iam::713287746880:role/DevSecOpsAdminRole",
]

#New Relic
new_relic_license = "2d0a4515f229d28736219458094132386ee1117c"
install_new_relic = "false"
