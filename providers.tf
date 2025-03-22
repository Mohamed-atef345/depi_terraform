terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.92.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

# state.tf
terraform {
  backend "s3" {
    bucket = "my-terraformstate-bucket123"
    key    = "state_file"
    region = "us-east-1"
  }
}

