variable "number_to_words_api_uri" {
  type        = "string"
  description = "URI of API Gateway to invoke lambda function"
}

locals {
  lambda_handler = "com.naresh.learning.handler.ConversionRequestHandler"
}
