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
  path_part   = "convert"
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

  integration_http_method = "GET"
  uri                     = "${var.number_to_words_api_uri}"
}
