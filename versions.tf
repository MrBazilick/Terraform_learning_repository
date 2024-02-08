provider "aws" {
  profile = var.profile
}

terraform {
  required_version = ">= 1.2.0"
}