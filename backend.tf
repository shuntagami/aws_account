terraform {
  backend "s3" {
    profile = "dev"
    region  = "ap-northeast-1"
    bucket  = "shuntagami-terraform-state"
    key     = "terraform/terraform.tfstate"
  }
}
