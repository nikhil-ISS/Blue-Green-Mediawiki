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
  #access_key = "AKIA4WM6FXUN26ZVNFF7"
  #secret_key = "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"
  region = var.region
}


module "B-G" {
  source = "./B-G"
}