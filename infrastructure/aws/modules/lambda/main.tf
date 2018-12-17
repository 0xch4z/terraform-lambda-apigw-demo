resource "aws_lambda_function" "lambda" {
  source_code_hash = "${base64sha256(file("${var.archive}"))}"
  filename         = "${var.archive}"
  function_name    = "${var.name}_${var.handler}"
  role             = "${var.role}"
  handler          = "bundle.handler"
  runtime          = "${var.runtime}"
  publish          = true
}
