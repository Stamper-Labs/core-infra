terraform {
  backend "s3" {
    bucket         = "stamper-labs-tfstate-bucket"
    key            = "global-stack/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "stamper-labs-tfstate-locks"
  }
}
