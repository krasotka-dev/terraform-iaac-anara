terraform {
  backend "s3" {
    bucket = "backend-state-farrukh"
    key    = "aws/iam/iam_state"
    region = "us-east-1"
  }
}