terraform {
  backend "s3" {
    bucket = "dev-eks-pos-farrukh"
    key    = "vet/us-east-1/sharedtools/dev-eks-poc/infrastructure.tfstate"
    region = "us-east-1"
  }
}
