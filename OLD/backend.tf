terraform {
  backend "s3" {
    bucket = "backend-state-farrukh"
    key    = "infrastructure"
    region = "us-east-1"
  }
}