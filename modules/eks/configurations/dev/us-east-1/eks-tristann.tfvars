#####
# Note: Make sure to pay close attention to update the below variables
# They are also used to derive the s3 folder location where terraform state is stored as well as kops state
# The state file will be stored at:
# s3://${s3_bucket}/${s3_folder_project}/${s3_folder_region}/${s3_folder_type}/${environment}/${s3_tfstate_file}
#####
environment       = "eks-tristann"
s3_bucket         = "mcd-vanguard-dev-tfstate" #Will be used to set backend.tf
s3_folder_project = "vet" #Will be used to set backend.tf
s3_folder_region  = "us-east-1" #Will be used to set backend.tf
s3_folder_type    = "sharedtools" #Will be used to set backend.tf
s3_tfstate_file   = "infrastructure.tfstate" #Will be used to set backend.tf

# Find out the parent hosted zone by running the below command
# aws route53 list-hosted-zones | jq '.HostedZones[] | select(.Name=="rndecp.net.") | .Id'
base_domain         = "vet-dev.digitalecp.mcd.com"
base_domain_zone_id = "Z1MXR1E16176X8"

#existing vpc id mapping
vpc_id = "vpc-0c1d18e7f896a1fff"

# existing security group id mappings
sg_ids {
  vpc_mgmt = "sg-07012ae96270ca08b"
}

worker_subnet_ids = [
  "subnet-03be8fb837ab2b49f", #us-east-1a
  "subnet-02740ed9a86a6450d", #us-east-1b
  "subnet-00ec3c426f3dc09fe", #us-east-1d
]

worker_public        = false

worker_instance_type = "m4.xlarge"
worker_asg_min_size  = 3
worker_asg_max_size  = 3

# CIDR blocks that should be able to ssh
allow_cidr_blocks = [
  "10.2.129.103/32",
  "10.135.8.0/21",      # (VDI)
  "10.135.160.0/21",    # (SSL VPN)
  "10.135.176.0/21",    # (SSL VPN)
  "10.135.184.0/21",    # (SSL VPN)
  "142.11.128.0/24",    # (VDI)
  "173.252.149.196/32", # (VDI Public IP)
  "152.140.0.0/15",     # (Corporate Offices)
  "209.65.177.128/32",  # (VDI Public IP)
  "66.111.184.233/32",  # (Smith)
  "10.1.0.0/20",        # (MCD Corp Network -- Do not allow in prod)
  "10.2.0.0/20",        # (Vet Dev Network  -- Do not allow in prod)
]

#existing ssh key name (for use with logging into instances)
ssh_aws_keyname = "k8s-dev"
#must be the *public* SSH key to match the ssh_aws_keyname above
ssh_public_key = "~/.ssh/k8s-dev.pub"

#tagging Value
tags {
  market              = "US"
  mcd_loc             = "US"
  vpc_id              = "DEV"
  vpc_id_brev         = "SG"
  region              = "US-EAST"
  app_brev            = "DEV1"
  mcd_app_code        = "US-AECP-DEV3"
  dac                 = "Datapipe_Automation"
  data_classification = "Sensitive"
  version             = "1.x"
  owner               = "Tristan Nyyssela"
  gbl                 = "195500433356"
  pyxis               = "14142"
  env_desc            = "EKS Test Cluster"
  static              = "false"
  patch_group         = "us-vet-non-prod"
}

map_roles = [
  {
    role_arn = "arn:aws:iam::607546651489:role/DevSecOpsAdminRole"
    username = "role1"
    group    = "system:masters"
  },
]

allow_roles = [
  "arn:aws:iam::607546651489:role/DevSecOpsAdminRole",
  "arn:aws:iam::607546651489:role/JenkinsSlavePodsRole"
]

#New Relic
new_relic_license = "2d0a4515f229d28736219458094132386ee1117c"
install_new_relic = "true"
