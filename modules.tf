terraform {
  required_version = "~> 0.13"

  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
  backend "remote" {

    organization = "B-G-Mediawiki"

    workspaces {
      name = "B-G-Mediawiki-workspace"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

module "B-G" {
  source = "./B-G"
}