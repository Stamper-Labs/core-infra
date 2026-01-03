# Core Infrastructure

This repository contains shared infrastructure code and configurations for managing cloud resources using Terraform.

Resources are organized into **stacks**, which can represent different services or cloud providers such as AWS, DigitalOcean, or Lightsail.

Each stack maintains its own **Terraform state**, allowing changes to be applied independently without affecting other stacks.

The repository is designed to provide **reusable modules** and **robust state management** for multiple environments and projects.

## Getting Started

### Install CLIs

Follow the official [CLI installation runbook](https://www.notion.so/Command-Line-Interfaces-2ddf2184fa3681d7aca2e8d0e3ac4392?source=copy_link),
to install and configure:

- AWS CLI
- Terraform CLI
- Ansible CLI

### Install runtime and package manager

Follow the official [Nodejs installation runbook](https://www.notion.so/NodeJS-2ddf2184fa368133b8cdd0b2c8b77836?source=copy_link)
to configure to install and configure:

- Nodejs 22
- yarn 1.22.22

### Setup Terraform State

If the Terraform state has not been created yet, 
follow the [official runbook to master the Terraform state](https://www.notion.so/Mastering-Terraform-State-2ddf2184fa36806cb5f9fd1faf5247ff?source=copy_link) like a pro.

## Available Stacks

- `base`: Core resources for the AWS cloud provider.
- `sail`: Resources for AWS Lightsail, designed for lightweight or simpler use cases.


## AWS Base Infrastructure

Run following commands to create AWS base infrastructure

```bash
yarn tinit --stack base
yarn tplan --stack base
yarn tapply --stack base -a
```

## LightSail Infrastructure

Run the following commands to create the LightSail infrastructure

- Create github actions role

  ```bash
  yarn tinit --stack base
  yarn tplan -s base -t module.stamper_role_github_actions -a
  yarn tapply -s base -t module.stamper_role_github_actions -a
  ```

- Create LightSail resources using terraform

  ```bash
  yarn tinit --stack sail
  yarn tplan --stack sail
  yarn tapply --stack sail -a
  ```

- Provision LightSail instance

  ```bash
  yarn instance-pb
  ```

## Command Line Interface

```bash
# Run `terraform init` for a specific stack
yarn tinit --stack <stack-name>

# Runs `terraform plan` for a specific stack
yarn tplan --stack <stack-name>

# Runs `terraform apply` for a specific stack
yarn tapply --stack <stack-name>
# Optionally the command can auto approve changes
yarn tapply --stack <stack-name> -a

# Runs `terraform destroy` for a specific stack
yarn tdes --stack <stack-name>
# Optionally the command can auto approve changes
yarn tdes --stack <stack-name> -a

# Runs `terraform output` for a specific stack
yarn touts --stack <stack-name>

# To display command documentation
yarn <command> --help
```
