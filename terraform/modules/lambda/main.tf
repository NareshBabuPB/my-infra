resource "aws_lambda_function" "number_to_words_conversion_lambda" {
  filename      = "${path.module}/code/transform-numbers-1.0-SNAPSHOT-jar-with-dependencies.jar"
  function_name = "number-to-words-conversion"
  role          = "${aws_iam_role.conversion_lambda_exec.arn}"
  handler       = "${local.lambda_handler}"
  runtime       = "java8"
}

resource "aws_lambda_permission" "allow_api_gateway" {
  statement_id  = "AllowExecutionFromApiGateway"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.number_to_words_conversion_lambda.function_name}"
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${var.number_to_words_api_uri}"
}
