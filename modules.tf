terraform {
  required_version = "~> 0.13"
}

provider "aws" {

  access_key = "AKIA5JHATFLKST7CZ5NJ"
  secret_key = "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"
  region = var.region
}


module "B-G" {
  source = "./B-G"
}