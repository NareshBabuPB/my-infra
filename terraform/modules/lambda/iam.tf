resource "aws_iam_role" "conversion_lambda_exec" {
  name               = "number-to-words-conversion-lambda-role"
  assume_role_policy = "${data.aws_iam_policy_document.lambda_exec_policy.json}"
}

data "aws_iam_policy_document" "lambda_exec_policy" {
  statement {
    actions = [
      "sts:AssumeRole",
    ]

    principals {
      identifiers = ["lambda.amazonaws.com"]

      type = "Service"
    }

    effect = "Allow"
  }
}
