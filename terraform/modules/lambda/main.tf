resource "aws_lambda_function" "number_to_words_conversion_lambda" {
  filename         = "${path.module}/code/transform-numbers-1.0-SNAPSHOT-jar-with-dependencies.jar"
  function_name    = "number-to-words-conversion"
  role             = "${aws_iam_role.conversion_lambda_exec.arn}"
  handler          = "com.naresh.learning.handler.ConversionRequestHandler"
  runtime          = "java8"
}