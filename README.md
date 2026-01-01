# Core Infrastructure

This repository contains shared infrastructure code and configurations for managing cloud resources using Terraform.

Resources are organized into **stacks**, which can represent different services or cloud providers such as AWS, DigitalOcean, or Lightsail.

Each stack maintains its own **Terraform state**, allowing changes to be applied independently without affecting other stacks.

The repository is designed to provide **reusable modules** and **robust state management** for multiple environments and projects.

## Getting Started

Install the following tools:

- [Install Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli#install-terraform)
- [Install Ansible](https://formulae.brew.sh/formula/ansible)
- Install Nodejs 22
- Install yarn 1.22.22
- Install aws cli

### Setup Terraform State

Follow this [runbook](https://www.notion.so/Governance-16ef2184fa368030a104cceeda94fd9d?source=copy_link#17df2184fa3680519fc1ef163fa8fa8f) for details to configure the terraform state.

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
