variable "number_to_words_lambda_arn" {
  type        = "string"
  description = "Lambda function ARN at which API is invoked"
}

variable "cw_role_arn" {
  type        = "string"
  description = "ARN of CW log role"
}
