terraform {
  backend "s3" {
    bucket = "terra-biekro-bucket"
    key    = "terraform/backend"
    region = "us-east-1"
  }
}