terraform {
  required_version = "~> 1.6"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.23"
    }
  }
}

provider "aws" {
  region = var.AWS_REGION
  shared_credentials_files = ["~/.aws/credentials"]
  profile                  = "awsdev"
}