provider "aws" {
  profile = var.profile
}

terraform {
  required_version = ">= 1.6.0"

  backend "s3" {
    bucket         = "my1remote1terra1state1bucket01" #name of my S3 bucket
    key            = "terraform-backend" #path within the bucket where the state file will be stored.
    region         = "eu-north-1" #s3 region of the bucket
    encrypt        = true #enable server-side encryption using S3's default SSE-S3 encryption.
  }
}