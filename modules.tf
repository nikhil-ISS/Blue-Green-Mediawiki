terraform {
  required_version = "~> 0.13"
}

provider "aws" {

  access_key = "******"
  secret_key = "******"
  region     = var.region
}


module "B-G" {
  source = "./B-G"
}