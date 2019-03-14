resource "aws_api_gateway_rest_api" "number_to_words_api" {
  name        = "number-to-words-api"
  description = "API to convert number to words"
}

# /convert/number-to-words
resource "aws_api_gateway_resource" "convert" {
  parent_id   = "${aws_api_gateway_rest_api.number_to_words_api.root_resource_id}"
  path_part   = "convert"
  rest_api_id = "${aws_api_gateway_rest_api.number_to_words_api.id}"
}

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
}

resource "aws_api_gateway_integration" "convert_number_to_words_get" {
  http_method = "${aws_api_gateway_method.convert_number_to_words_get.http_method}"
  resource_id = "${aws_api_gateway_resource.convert_number_to_words.id}"
  rest_api_id = "${aws_api_gateway_rest_api.number_to_words_api.id}"
  type        = "AWS_PROXY"

  integration_http_method = "POST"
  uri                     = "${var.number_to_words_api_uri}"
}

resource "aws_api_gateway_deployment" "number_to_words_api_deployment" {
  rest_api_id = "${aws_api_gateway_rest_api.number_to_words_api.id}"
  stage_name  = "live"
}

resource "aws_api_gateway_stage" "number_to_words_api_stage" {
  deployment_id = "${aws_api_gateway_deployment.number_to_words_api_deployment.id}"
  rest_api_id   = "${aws_api_gateway_rest_api.number_to_words_api.id}"
  stage_name    = "live"
}
