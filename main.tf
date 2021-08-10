locals {
  wait_for_apply = var.force_wait_for_apply ? uuid() : null
}

data "aws_lambda_invocation" "shell" {
  depends_on = [
    var.lambda_shell_module,
  ]
  function_name = local.wait_for_apply == null ? var.lambda_shell_module.invicton_labs_lambda_shell_arn : var.lambda_shell_module.invicton_labs_lambda_shell_arn
  input = jsonencode({
    interpreter = var.interpreter
    command = var.command
    fail_on_error = var.fail_on_error
  })
}

locals {
    result = jsondecode(data.aws_lambda_invocation.shell.result)
}