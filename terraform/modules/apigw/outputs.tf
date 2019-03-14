output "number_to_words_api_uri" {
  value = "${aws_api_gateway_rest_api.number_to_words_api.execution_arn}/*/${aws_api_gateway_integration.convert_number_to_words_get.http_method}${aws_api_gateway_resource.convert_number_to_words.path}"
}
