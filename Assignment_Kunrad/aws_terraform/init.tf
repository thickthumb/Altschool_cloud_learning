
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.55.0"
    }
  }
}

provider "aws" {
  region = "us-west-2"
  access_key = var.bolt_input
  secret_key = var.nut_input
}


