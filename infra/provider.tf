terraform {

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket         = "your-terraform-state-bucket"
    key            = "terraform/state"
    region         = "us-west-2"
    dynamodb_table = "terraform-lock-table"
  }
}

provider "aws" {
  region = "us-east-1"
}
