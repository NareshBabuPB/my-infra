output "number_to_words_lambda_arn" {
  value = "${aws_lambda_function.number_to_words_conversion_lambda.invoke_arn}"
}
