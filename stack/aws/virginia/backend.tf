terraform {
  backend "s3" {
    bucket         = "stamperlabs-tfstate-bucket-virginia"
    key            = "virginia/terraform.tfstate"
    encrypt        = true
    dynamodb_table = "stamperlabs-tfstate-locks-virginia"
    region         = "us-east-1"
    profile        = "owners-virginia"
  }
}