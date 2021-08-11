output "stdout" {
  description = "The stdout output of the shell command."
  value       = local.result.stdout
}

output "stderr" {
  description = "The stderr output of the shell command."
  value       = local.result.stderr
}

output "exitstatus" {
  description = "The exit status code of the shell command."
  value       = local.result.exitstatus
}
