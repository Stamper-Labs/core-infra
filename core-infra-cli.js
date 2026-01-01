#!/usr/bin/env node

const { Command } = require('commander');
const { spawn } = require('child_process');
const path = require('path');

const program = new Command();
const STACK_OPTION_DESCRIPTION = 'Specify which Terraform stack to run. Available stacks: base, sail';

program
  .name('core-infra-cli')
  .description('CLI to run core infra');

// --- Helper function ---
function runTerraform(cmd, stack) {

  const stackDir = `./stack/aws/${stack}`;

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
  .requiredOption('-s, --stack <stack>', STACK_OPTION_DESCRIPTION)
  .action((options) => {
    const stack = options.stack;
    runTerraform('init', stack);
  });

program
  .command('plan')
  .description('Run terraform plan')
  .requiredOption('-s, --stack <stack>', STACK_OPTION_DESCRIPTION)
  .option('-t, --target <target>', 'Specify a Terraform target module')
  .action((options) => {
    const stack = options.stack;
    const target = options.target ? `-target=${options.target}` : '';
    const cmd = ['plan', target].filter(Boolean).join(' ');
    runTerraform(cmd, stack);
  });

program
  .command('apply')
  .description('Run terraform apply (with optional auto-approve)')
  .requiredOption('-s, --stack <stack>', STACK_OPTION_DESCRIPTION)
  .option('-a, --auto-approve', 'Enable auto-approve flag', false)
  .option('-t, --target <target>', 'Specify a Terraform target module')
  .action((options) => {
    const stack = options.stack;

    // Build the Terraform command dynamically
    const parts = ['apply'];
    if (options.autoApprove) parts.push('-auto-approve');
    if (options.target) parts.push(`-target=${options.target}`);

    const cmd = parts.join(' ');

    runTerraform(cmd, stack);
  });

program
  .command('destroy')
  .description('Run terraform destroy (with optional auto-approve)')
  .requiredOption('-s, --stack <stack>', STACK_OPTION_DESCRIPTION)
  .option('-a, --auto-approve', 'Enable auto-approve flag', false)
  .option('-t, --target <target>', 'Specify a Terraform target module')
  .action((options) => {
    const stack = options.stack;

    // Build the Terraform command dynamically
    const parts = ['destroy'];
    if (options.autoApprove) parts.push('-auto-approve');
    if (options.target) parts.push(`-target=${options.target}`);

    const cmd = parts.join(' ');

    runTerraform(cmd, stack);
  });

program
  .command('output-all')
  .requiredOption('-s, --stack <stack>', STACK_OPTION_DESCRIPTION)
  .description('Run terraform output -json to get all outputs in JSON format')
  .action((options) => {
    const stack = options.stack;
    runTerraform('output -json', stack);
  });

// --- NEW: run-playbooks command ---
program
  .command('run-lightsail-instance-playbook')
  .description('Execute an Ansible playbook on the Lightsail instance')
  .action(() => {

    const lightsailDir = path.join(process.cwd(), 'stack', 'aws', 'sail');
    const inventoryFile = path.join(lightsailDir, 'dist', 'inventory.ini');
    const playbookFile = path.join(lightsailDir, 'playbook', `instance.yaml`);

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