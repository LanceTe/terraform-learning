terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

module "create-s3-bucket" {
  source  = "./create-s3-bucket"
  regions = var.regions
}

module "update-s3-bucket" {
  source       = "./update-s3-bucket"
  regions      = var.regions
  environment  = var.environment
  cors_enabled = true
}

module "upload-file" {
  source = "./upload-file"
}
