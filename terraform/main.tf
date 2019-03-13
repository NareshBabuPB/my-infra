module "apigw" {
  source = "modules/apigw"

  number_to_words_api_uri = "${module.lambda.number_to_words_lambda_uri}"
}

module "lambda" {
  source = "modules/lambda"

  number_to_words_api_uri = "${module.apigw.number_to_words_api_uri}"
}
