provider "aws" {
  region = "us-east-1"
}

terraform {
  required_version = ">= 1.5.0"
  required_providers {
       aws = {
      source  = "hashicorp/aws"
      version = "5.83.1"
  
    }
  }
}


terraform {
  backend "s3" {
    bucket = "sctp-ce9-tfstate"
    key    = "chrisy-s3-tf-ci.tfstate" #Change this
    region = "us-east-1"
  }
}

data "aws_caller_identity" "current" {}

locals {
  name_prefix = split("/", "${data.aws_caller_identity.current.arn}")[1]
  account_id  = data.aws_caller_identity.current.account_id
}

resource "aws_s3_bucket" "s3_tf" {
  bucket = "${local.name_prefix}-s3-tf-bkt-${local.account_id}"
}