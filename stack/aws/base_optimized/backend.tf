terraform {
  backend "s3" {
    bucket         = "stamper-labs-tfstate-bucket-ohio"
    key            = "base_optimized/terraform.tfstate"
    region         = "us-east-2"
    encrypt        = true
    dynamodb_table = "stamper-labs-tfstate-locks-ohio"
  }
}