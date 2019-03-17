module "apigw" {
  source = "modules/apigw"

  number_to_words_api_uri = "${module.lambda.number_to_words_lambda_uri}"
  cw_role_arn = "${module.iam.cw_role_arn}"
}

module "lambda" {
  source = "modules/lambda"

  number_to_words_api_uri = "${module.apigw.number_to_words_api_uri}"
}

module "iam" {
  source = "modules/iam"
}
