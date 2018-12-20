provider "aws" {
  secret_key = "${var.secret_key}"
  access_key = "${var.access_key}"
  region     = "${var.region}"
}

data "aws_caller_identity" "current" { }

# IAM role for using lambda
resource "aws_iam_role" "iam_role_for_lambda" {
  name = "iam_role_for_lambda"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

module "lambda" {
  source  = "./modules/lambda"
  name    = "hello_lambda"
  archive = "../../dist/lambda.zip"
  runtime = "nodejs8.10"
  role    = "${aws_iam_role.iam_role_for_lambda.arn}"
}

resource "aws_api_gateway_rest_api" "hello_api" {
  name = "hello_api"
}

resource "aws_api_gateway_resource" "hello_api_res_hello" {
  rest_api_id = "${aws_api_gateway_rest_api.hello_api.id}"
  parent_id   = "${aws_api_gateway_rest_api.hello_api.root_resource_id}"
  path_part   = "hello"
}

module "hello_get" {
  source      = "./modules/api_method"
  rest_api_id = "${aws_api_gateway_rest_api.hello_api.id}"
  resource_id = "${aws_api_gateway_resource.hello_api_res_hello.id}"
  method      = "GET"
  path        = "${aws_api_gateway_resource.hello_api_res_hello.path}"
  lambda      = "${module.lambda.name}"
  region      = "${var.region}"
  account_id  = "${data.aws_caller_identity.current.account_id}"
  lambda_arn  = "${module.lambda.arn}"
}

resource "aws_api_gateway_deployment" "hello_api_deployment" {
  rest_api_id = "${aws_api_gateway_rest_api.hello_api.id}"
  stage_name  = "production"
  description = "Deploy methods: ${module.hello_get.http_method}"
}
