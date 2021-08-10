variable "lambda_shell_module" {
  description = "An `Invicton-Labs/lambda-shell/aws` module (https://registry.terraform.io/modules/Invicton-Labs/request-signer/aws). Pass the entire module in as this parameter (e.g. `lambda_shell_module = module.lambda-shell`)."
  type = object({
    invicton_labs_lambda_shell_arn = string
  })
}

variable "force_wait_for_apply" {
  description = "Whether to force this module to wait for apply-time to execute the shell command. Otherwise, it will run during plan-time if possible (i.e. if all inputs are known during plan time)."
  type        = bool
  default     = false
}

variable "interpreter" {
  description = "The interpreter (e.g. `sh`, `bash`, `python3`) and flags to use as provided (if the `script` input parameter is not provided) or to use to run the provided `script`. The input format is a list of strings, such as `[\"bash\", \"-d\"]`."
  type        = list(string)
  default     = ["bash"]
}

variable "command" {
  description = "The command to be run by the given interpreter. This field can be multi-line; the content will be stored in a file and executed by the given interpreter."
  type        = string
}

variable "fail_on_error" {
  type        = bool
  default     = false
  description = "Whether a Terraform error should be thrown if the command returns a non-zero exit code. If true, nothing will be returned from this module and Terraform will fail the apply. If false, the error message will be returned in `stderr` and the error code will be returned in `exitstatus`. Default: `false`."
}
