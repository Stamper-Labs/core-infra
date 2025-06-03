# Base Infrastructure

This repository contains shared infrastructure code and configurations for managing AWS resources using Terraform. It is intended to provide reusable modules and state management for multiple environments and projects.

## Getting Started

Install the following tools:

- Install Terraform
- Install Nodejs 22
- Install yarn 1.22.22
- Install aws cli

### Configure AWS profile

- Grab the secret and access keys from the AWS web console.

- Open `config` file for edition:

  ```bash
  # Create the .aws folder in case it does not exist
  mkdir ~/.aws/
  nano ~/.aws/config
  ```

- Add the following profile

  ```bash
  [profile stamper-prod]
  region = us-east-1
  ```

- Open `credentials` file for edition

  ```bash
  nano ~/.aws/credentials
  ```

- Paste credentials

  ```bash
  [stamper-prod]
  aws_access_key_id = your_aws_access_key_id
  aws_secret_access_key = your_aws_secret_access_key
  ```

- Verify the configuration

  ```bash
  aws sts get-caller-identity --profile stamper-prod
  ```

- Enable profile via env variable

  ```bash
  export AWS_PROFILE=stamper-prod
  ```

### Setup the Terraform State

- Create state terrafom bucket

  ```bash
    aws --profile stamper-prod s3api create-bucket \
    --bucket stamper-labs-tfstate-bucket \
    --region us-east-1 \
  ```

- Enable bucket versioning

  ```bash
    aws --profile stamper-prod s3api put-bucket-versioning \
    --bucket stamper-labs-tfstate-bucket \
    --versioning-configuration Status=Enabled
  ```

- Create the lock table

  ```bash
    aws --profile stamper-prod dynamodb create-table \
    --table-name stamper-labs-tfstate-locks \
    --attribute-definitions AttributeName=LockID,AttributeType=S \
    --key-schema AttributeName=LockID,KeyType=HASH \
    --billing-mode PAY_PER_REQUEST \
    --region us-east-1
  ```

- Create state folder

  ```bash
  aws --profile stamper-prod s3api put-object \
  --bucket stamper-labs-tfstate-bucket \
  --key base
  ```

## Command Line Interface

These npm scripts automate common Terraform tasks for the `envs/prod` environment. You can run them with `npm run <script-name>`.

```bash
# Runs `terraform init` in the `envs/prod` directory
# to initialize the Terraform working directory.
yarn tf:init

# Runs `terraform plan` in `envs/prod`
# to show the execution plan (what Terraform will do).
yarn tf:plan

# Runs `terraform apply --auto-approve` in `envs/prod`
# to apply the Terraform configuration without asking for confirmation.
yarn tf:apply

# Runs `terraform destroy --auto-approve` in `envs/prod`
# to destroy all managed infrastructure without asking for confirmation.
yarn tf:destroy

# Runs `terraform output` in `envs/prod`
# to display the output values from the Terraform state.
yarn tf:output

# Runs `terraform fmt -recursive`
# to format all Terraform files in the project and its subdirectories.
yarn tf:format

# Runs `terraform fmt -recursive -check`
# to check if all Terraform files are properly formatted (without making changes).
yarn tf:format:check
```
