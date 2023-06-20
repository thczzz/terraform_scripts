terraform {
  backend "s3" {
    bucket = "vprofile-kops-state-343"
    key    = "terraform/backend"
    region = var.REGION
  }
}
