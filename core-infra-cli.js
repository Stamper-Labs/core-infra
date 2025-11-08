#!/usr/bin/env node

const { Command } = require('commander');
const { spawn } = require('child_process');
const path = require('path');

const program = new Command();

program
  .name('core-infra-cli')
  .description('CLI to run core infra')
  .version('1.1.0');

// --- Helper function ---
function runTerraform(cmd, stack) {

  const stackDir = `./aws/bootstrap/${stack}`;

  console.log(`🧩 Using stack: ${stack}`);
  console.log(`🚀 Running: terraform ${cmd} inside ${stackDir}`);

  const shellCommand = `cd ${stackDir} && terraform ${cmd}`;
  const terraformProcess = spawn(shellCommand, { stdio: 'inherit', shell: true });

  terraformProcess.on('exit', (code) => {
    if (code !== 0) {
      console.error(`❌ terraform ${cmd} failed with exit code ${code}`);
      process.exit(code);
    } else {
      console.log(`✅ terraform ${cmd} completed successfully`);
    }
  });
}

// --- Commands ---
program
  .command('init')
  .description('Run terraform init')
  .requiredOption('--stack <name>', 'Specify which Terraform stack to run (e.g., core-infra, staging, prod)')
  .action((options) => {
    const stack = options.stack;
    runTerraform('init', stack);
  });

program
  .command('plan')
  .description('Run terraform plan')
  .requiredOption('--stack <name>', 'Specify which Terraform stack to run (e.g., core-infra, staging, prod)')
  .action((options) => {
    const stack = options.stack;
    runTerraform('plan', stack);
  });

program
  .command('apply')
  .description('Run terraform apply (with optional auto-approve)')
  .requiredOption('--stack <name>', 'Specify which Terraform stack to run (e.g., core-infra, staging, prod)')
  .option('--auto-approve', 'Enable auto-approve flag', false)
  .action((options) => {
    const stack = options.stack;
    const cmd = options.autoApprove ? 'apply -auto-approve' : 'apply';
    runTerraform(cmd, stack);
  });

program
  .command('destroy')
  .description('Run terraform destroy (with optional auto-approve)')
  .requiredOption('--stack <name>', 'Specify which Terraform stack to run (e.g., core-infra, staging, prod)')
  .option('--auto-approve', 'Enable auto-approve flag', false)
  .action((options) => {
    const stack = options.stack;
    const cmd = options.autoApprove ? 'destroy -auto-approve' : 'destroy';
    runTerraform(cmd, stack);
  });

program
  .command('output-all')
  .requiredOption('--stack <name>', 'Specify which Terraform stack to run (e.g., core-infra, staging, prod)')
  .description('Run terraform output -json to get all outputs in JSON format')
  .action((options) => {
    const stack = options.stack;
    runTerraform('output -json', stack);
  });

// --- NEW: run-playbooks command ---
program
  .command('run-lightsail-playbook')
  .description('Execute an Ansible playbook on the Lightsail instance')
  .option('--name <playbook>', 'Playbook name to run (without .yaml)', 'k8s')
  .action((options) => {
    const playbookName = options.name;

    const lightsailDir = './aws/bootstrap/lightsail';
    const inventoryFile = `./dist/inventory.ini`;
    const playbookFile = `./playbook/${playbookName}.yaml`

    const ansibleCmd = `cd ${lightsailDir} && ansible-playbook -i ${inventoryFile} ${playbookFile}`;

    console.log(`🚀 Running: ${ansibleCmd}`);
    const proc = spawn(ansibleCmd, { stdio: 'inherit', shell: true });

    proc.on('exit', (code) => {
      if (code !== 0) {
        console.error(`❌ Playbook failed with exit code ${code}`);
        process.exit(code);
      } else {
        console.log('✅ Playbook executed successfully');
      }
    });
  });

program.parse(process.argv);