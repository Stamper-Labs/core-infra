# Core Infrastructure

This repository contains shared infrastructure code and configurations for managing cloud resources using Terraform.

Resources are organized into **stacks**, which can represent different services or cloud providers such as AWS, DigitalOcean, or Lightsail. 
Each stack maintains its own **Terraform state**, allowing changes to be applied independently without affecting other stacks.

The repository includes a Node.js–based CLI that simplifies day-to-day operations. This CLI provides a consistent and easy way to:

- Execute Terraform commands (plan, apply, destroy)
- Run Ansible playbooks

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

### Setup Terraform State (Optional)

Create the terraform state for `us-east-1` and `us-east-2` regions, following the official
[runbook to master the erraform state](https://www.notion.so/Mastering-Terraform-State-2ddf2184fa36806cb5f9fd1faf5247ff?source=copy_link).

### Install Project Dependencies

```bash
yarn install
```

## Available Stacks

- `global`: Set of terraform resources that are not tied to a specific AWS region
- `virginia`: Set of terraform core resources on AWS `us-east-1` region.
- `ohio`: Set of cost-effective terrafrom core resources on AWS `us-east-2` region.
- `sail`: Resources for AWS Lightsail, designed for lightweight or simpler use cases.

## AWS `global` Stack

The global stack is common to all other AWS stacks. Make sure to install it first, 
before proceeding with the other stacks.

```bash
yarn tinit --stack global
yarn tplan --stack global
yarn tapply --stack global -a
```

## AWS `virginia` Stack (`us-east-1` region)

```bash
yarn tinit --stack virginia
yarn tplan --stack virginia
yarn tapply --stack virginia -a
```

## AWS `ohio` Stack (`us-east-2` region)

```bash
yarn tinit --stack ohio
yarn tplan --stack ohio
yarn tapply --stack ohio -a
```

## LightSail Infrastructure

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
