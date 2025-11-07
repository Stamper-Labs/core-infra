#!/usr/bin/env node

const { Command } = require('commander');
const { spawn } = require('child_process');
const fs = require('fs');

const program = new Command();

program
  .name('terraform-cli')
  .description('CLI to run Terraform commands with stack support')
  .version('1.1.0');

// --- Helper function ---
function runTerraform(cmd, stack) {

  const stackDir = `./aws/stacks/${stack}`;

  if (!fs.existsSync(stackDir)) {
    console.error(`❌ Stack directory not found: ${stackDir}`);
    process.exit(1);
  }

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

// Shared stack option (now required)
program.requiredOption('--stack <name>', 'Specify which Terraform stack to run (e.g., core-infra, staging, prod)');

// --- Commands ---
program
  .command('init')
  .description('Run terraform init')
  .action(() => {
    const { stack } = program.opts();
    runTerraform('init', stack);
  });

program
  .command('plan')
  .description('Run terraform plan')
  .action(() => {
    const { stack } = program.opts();
    runTerraform('plan', stack);
  });

program
  .command('apply')
  .description('Run terraform apply (with optional auto-approve)')
  .option('--auto-approve', 'Enable auto-approve flag', false)
  .action((options) => {
    const { stack } = program.opts();
    const cmd = options.autoApprove ? 'apply -auto-approve' : 'apply';
    runTerraform(cmd, stack);
  });

program
  .command('destroy')
  .description('Run terraform destroy (with optional auto-approve)')
  .option('--auto-approve', 'Enable auto-approve flag', false)
  .action((options) => {
    const { stack } = program.opts();
    const cmd = options.autoApprove ? 'destroy -auto-approve' : 'destroy';
    runTerraform(cmd, stack);
  });

program
  .command('output-all')
  .description('Run terraform output -json to get all outputs in JSON format')
  .action(() => {
    const { stack } = program.opts();
    runTerraform('output -json', stack);
  });

program.parse(process.argv);