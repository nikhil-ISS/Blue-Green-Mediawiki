terraform {
  required_version = "~> 0.13"
  aws = {
      source  = "hashicorp/aws"
      version = "~> 2.70"
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