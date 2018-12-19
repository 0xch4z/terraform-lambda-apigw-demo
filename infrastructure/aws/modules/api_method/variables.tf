variable "rest_api_id" {
  description = "ID of the associated REST API"
}

variable "resource_id" {
  description = "API resource ID"
}

variable "method" {
  description = "HTTP method"
  default     = "GET"
}

variable "path" {
  description = "API resource path"
}

variable "lambda" {
  description = "lambda name to invoke"
}

variable "region" {
  description = "AWS region"
}

variable "account_id" {
  description = "AWS account ID"
}

variable "lambda_arn" {
  description = "ARN of lambda to integrate"
}
