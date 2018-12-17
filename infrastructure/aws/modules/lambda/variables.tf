variable "name" {
  description = "name of the lambda to create"
}

variable "runtime" {
  description = "runtime of the lambda to create"
}

variable "handler" {
  description = "handler name of lambda (function defined in lambda)"
  default = "handler"
}

variable "role" {
  description = "IAM role for the Lambda Function (ARN)"
}

variable "archive" {
  description = "zip archive containing lambda module"
}
