# shared-infra

This repository contains shared infrastructure code and configurations for managing AWS resources using Terraform. It is intended to provide reusable modules and state management for multiple environments and projects.

## Getting Started

### Create the terraform state key

```bash
aws --profile stamper-prod s3api put-object \
--bucket stamper-labs-tfstate-bucket \
--key shared/prod
```

## Command Line Interface

These npm scripts automate common Terraform tasks for the `envs/prod` environment. You can run them with `npm run <script-name>`.

```bash
# Runs `terraform init` in the `envs/prod` directory to initialize the Terraform working directory.
yarn tf:init

# Runs `terraform plan` in `envs/prod` to show the execution plan (what Terraform will do).
yarn tf:plan

# Runs `terraform apply --auto-approve` in `envs/prod` to apply the Terraform configuration without asking for confirmation.
yarn tf:apply

# Runs `terraform destroy --auto-approve` in `envs/prod` to destroy all managed infrastructure without asking for confirmation.
yarn tf:destroy

# Runs `terraform output` in `envs/prod` to display the output values from the Terraform state.
yarn tf:output

# Runs `terraform fmt -recursive` to format all Terraform files in the project and its subdirectories.
yarn tf:format

# Runs `terraform fmt -recursive -check` to check if all Terraform files are properly formatted (without making changes).
yarn tf:format.check
```
