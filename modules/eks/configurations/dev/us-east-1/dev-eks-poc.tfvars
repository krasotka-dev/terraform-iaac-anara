#####
# Note: Make sure to pay close attention to update the below variables
# They are also used to derive the s3 folder location where terraform state is stored as well as kops state
# The state file will be stored at:
# s3://${s3_bucket}/${s3_folder_project}/${s3_folder_region}/${s3_folder_type}/${environment}/${s3_tfstate_file}
#####
environment       = "dev-eks-poc"
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
  "subnet-0c7d811502b44812b", #us-east-1a-4
  "subnet-06b95c503090097af", #us-east-1b-4
  "subnet-01b478f6e74b8612f", #us-east-1c-4
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
  "10.1.0.0/20",        # (MCD Corp Network -- Do not allow in prod)
  "10.2.0.0/20",        # (Vet Dev Network  -- Do not allow in prod)
  "10.1.4.64/32",       # DAC
  "152.141.5.0/24",     # mulesoft uat
  "152.141.6.0/24",     # mulesoft dev
  "10.2.162.0/25",      # Tools account
  "10.135.16.0/21",     # New VDI IP Range
  "10.2.163.0/24",      # (Tools Additional subnets)
  "10.135.24.0/23",     # New VDI range
  "10.135.23.0/24",     # NEW VDI Range
]

#existing ssh key name (for use with logging into instances)
ssh_aws_keyname = "k8s-dev"
#must be the *public* SSH key to match the ssh_aws_keyname above
ssh_public_key = "~/.ssh/k8s-dev.pub"

ami_id = "ami-02346ab433eed2530"

kubernetes_version = "1.13"

### Input values for common tagging module - see the resource-tagging module in VETTM repo for more information

tags {
  #Mandatory tags
  Environment        = "US-EAST-DEV-US-VET-AECP-DEVCLUSTERINFRASTRUCTURE"
  GBL                = "195500433356"
  ApplicationID      = "APP0012189"
  Owner              = "US-VET-INFRASUPPORT@us.mcd.com"
  "Patch Group"      = "Not-Patched-By-2W"
  "cpm backup"       = "mcds_us_none_4_non_prod_607546651489"

  #Additional tags
  Name      = "US-EAST-DEV-US-VET-AECP-DEVCLUSTERINFRASTRUCTURE"
  ManagedBy = "Terraform"
  Cluster   = "DEV-EKS-POC"
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
