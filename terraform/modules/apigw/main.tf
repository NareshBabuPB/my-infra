resource "aws_api_gateway_rest_api" "number_to_words_api" {
  name        = "number-to-words-api"
  description = "API for number-to-wrods-conversion lambda function"
}

# /convert
resource "aws_api_gateway_resource" "convert" {
  parent_id   = "${aws_api_gateway_rest_api.number_to_words_api.root_resource_id}"
  path_part   = "convert"
  rest_api_id = "${aws_api_gateway_rest_api.number_to_words_api.id}"
}

# /convert/number-to-words
resource "aws_api_gateway_resource" "convert_number_to_words" {
  parent_id   = "${aws_api_gateway_resource.convert.id}"
  path_part   = "number-to-words"
  rest_api_id = "${aws_api_gateway_rest_api.number_to_words_api.id}"
}

resource "aws_api_gateway_method" "convert_number_to_words_get" {
  authorization = "NONE"
  http_method   = "GET"
  resource_id   = "${aws_api_gateway_resource.convert_number_to_words.id}"
  rest_api_id   = "${aws_api_gateway_rest_api.number_to_words_api.id}"

  request_validator_id = "${aws_api_gateway_request_validator.number_to_words_api_request_validator.id}"

  request_parameters {
    "method.request.querystring.inputNumber" = true
  }
}

resource "aws_api_gateway_integration" "convert_number_to_words_get" {
  http_method = "${aws_api_gateway_method.convert_number_to_words_get.http_method}"
  resource_id = "${aws_api_gateway_resource.convert_number_to_words.id}"
  rest_api_id = "${aws_api_gateway_rest_api.number_to_words_api.id}"
  type        = "AWS"

  integration_http_method = "POST"
  uri                     = "${var.number_to_words_lambda_arn}"

  request_templates = {
    "application/json" = "${file("${path.module}/template/query_string_mapping.template")}"
  }
}

resource "aws_api_gateway_request_validator" "number_to_words_api_request_validator" {
  name                        = "number-to-words-api-request-validator"
  rest_api_id                 = "${aws_api_gateway_rest_api.number_to_words_api.id}"
  validate_request_body       = false
  validate_request_parameters = true
}

resource "aws_api_gateway_method_response" "number_to_words_api_response" {
  http_method = "${aws_api_gateway_method.convert_number_to_words_get.http_method}"
  resource_id = "${aws_api_gateway_resource.convert_number_to_words.id}"
  rest_api_id = "${aws_api_gateway_rest_api.number_to_words_api.id}"
  status_code = "200"
}

resource "aws_api_gateway_integration_response" "number_to_words_api_get" {
  http_method = "${aws_api_gateway_method.convert_number_to_words_get.http_method}"
  resource_id = "${aws_api_gateway_resource.convert_number_to_words.id}"
  rest_api_id = "${aws_api_gateway_rest_api.number_to_words_api.id}"
  status_code = "${aws_api_gateway_method_response.number_to_words_api_response.status_code}"

  response_templates = {
    "application/json" = "${file("${path.module}/template/response_mapping.template")}"
  }
}

resource "aws_api_gateway_deployment" "number_to_words_api_deployment" {
  depends_on = ["aws_api_gateway_integration.convert_number_to_words_get"]

  rest_api_id = "${aws_api_gateway_rest_api.number_to_words_api.id}"
  stage_name  = "live"
}

resource "aws_api_gateway_account" "api_account" {
  cloudwatch_role_arn = "${var.cw_role_arn}"
}

resource "aws_api_gateway_method_settings" "api_method_config" {
  depends_on = ["aws_api_gateway_deployment.number_to_words_api_deployment"]

  method_path = "*/*"
  rest_api_id = "${aws_api_gateway_rest_api.number_to_words_api.id}"
  stage_name  = "live"

  "settings" {
    logging_level = "INFO"
  }
}
