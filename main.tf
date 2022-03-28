locals {
  wait_for_apply = var.force_wait_for_apply ? uuid() : null
  input = jsonencode({
    interpreter = var.interpreter
    // Remove carriage returns from commands, since they'll be running in a Linux environment
    command                   = replace(replace(var.command, "\r", ""), "\r\n", "\n")
    fail_on_nonzero_exit_code = var.fail_on_nonzero_exit_code
    fail_on_stderr            = var.fail_on_stderr
    fail_on_timeout           = var.fail_on_timeout
    timeout                   = var.timeout == null ? null : (var.timeout <= 0 ? null : var.timeout)
    environment               = var.sensitive_environment == null || length(var.sensitive_environment) == 0 ? (var.environment == null ? {} : var.environment) : sensitive(merge((var.environment == null ? {} : var.environment), var.sensitive_environment))
  })

}

data "aws_lambda_invocation" "shell" {
  depends_on = [
    var.lambda_shell_module,
  ]
  function_name = local.wait_for_apply == null ? var.lambda_shell_module.invicton_labs_lambda_shell_arn : var.lambda_shell_module.invicton_labs_lambda_shell_arn
  input         = var.suppress_console ? sensitive(local.input) : local.input
}

locals {
  result = jsondecode(data.aws_lambda_invocation.shell.result)
}
