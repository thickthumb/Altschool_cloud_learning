
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.55.0"
    }
  }
}

provider "aws" {
  # Configuration options
}



module "apigateway-v2" {
  source  = "terraform-aws-modules/apigateway-v2/aws"
  version = "5.0.0"
}

module "s3-bucket" {
  source  = "cloudposse/s3-bucket/aws"
  version = "4.2.0"
}

module "cloudfront" {
  source  = "terraform-aws-modules/cloudfront/aws"
  version = "3.4.0"
}



module "route53" {
  source  = "mineiros-io/route53/aws"
  version = "0.6.0"
  # insert the 4 required variables here
}
