terraform {
  required_version = "~> 0.13"
}

provider "aws" {

  #access_key = "ACCESS_KEY"
  #secret_key = "SECRTE_KEY"
  region  = var.region
}


module "B-G"{
  source = "./B-G"
}