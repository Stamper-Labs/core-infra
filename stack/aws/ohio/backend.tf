terraform {
  backend "s3" {
    bucket         = "stamperlabs-tfstate-bucket-ohio"
    key            = "ohio/terraform.tfstate"
    region         = "us-east-2"
    profile        = "owners-ohio"
    encrypt        = true
    dynamodb_table = "stamperlabs-tfstate-locks-ohio"
  }
}