data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = [
      "sts:AssumeRole",
    ]

    principals {
      identifiers = ["apigateway.amazonaws.com"]

      type = "Service"
    }

    effect = "Allow"
  }
}

data "aws_iam_policy_document" "cw_log_policy" {
  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams",
      "logs:PutLogEvents",
      "logs:GetLogEvents",
      "logs:FilterLogEvents",
    ]

    resources = [
      "*"
    ]

    effect = "Allow"
  }
}

resource "aws_iam_role" "cw_log" {
  assume_role_policy = "${data.aws_iam_policy_document.assume_role_policy.json}"
}

resource "aws_iam_role_policy" "cw_log" {
  policy = "${data.aws_iam_policy_document.cw_log_policy.json}"
  role = "${aws_iam_role.cw_log.id}"
}