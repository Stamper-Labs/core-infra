#!/usr/bin/env node

const { Command } = require('commander');
const { spawn } = require('child_process');
const program = new Command();

program
  .name('terraform CLI')
  .description('CLI to run Terraform commands')
  .version('1.0.0');

function runTerraform(cmd) {
  const scriptsDir = './aws/scripts'; 
  const shellCommand = `cd ${scriptsDir} && terraform ${cmd}`;

  const terraformProcess = spawn(shellCommand, {
    stdio: 'inherit',
    shell: true 
  });
  terraformProcess.on('exit', code => {
    if (code !== 0) {
      console.error(`❌ terraform ${cmd} failed with exit code ${code}`);
      process.exit(code);
    }
  });
}

program
  .command('init')
  .description('Run terraform init')
  .action(() => {
    runTerraform('init');
  });

program
  .command('plan')
  .description('Run terraform plan')
  .action(() => {
    runTerraform('plan');
  });

program
  .command('apply')
  .description('Run terraform apply (with optional auto-approve)')
  .option('--auto-approve', 'Enable auto-approve flag', false)
  .action((options) => {
    const cmd = options.autoApprove
      ? 'apply -auto-approve'
      : 'apply';
    runTerraform(cmd);
  });

program
  .command('destroy')
  .description('Run terraform destroy (with optional auto-approve)')
  .option('--auto-approve', 'Enable auto-approve flag', false)
  .action((options) => {
    const cmd = options.autoApprove 
      ? 'destroy -auto-approve' 
      : 'destroy';
    runTerraform(cmd);
  });

  program
  .command('output-all')
  .description('Run terraform output -json to get all outputs in JSON format')
  .action(() => {
    runTerraform('output -json');
  });

program.parse(process.argv);