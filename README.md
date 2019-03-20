# REST API - Number to Words Convertor


Terraform config to deploy the [transform-numbers lambda function](https://github.com/NareshBabuPB/transform-numbers) and expose it via a REST API.

### REST API:

The lambda function can be invoked through the deployed API by submitting a GET request to below URL with different values for `inputNumber` query string.

https://j6x960lxyb.execute-api.us-east-2.amazonaws.com/live/convert/number-to-words?inputNumber=167534

API response will be a JSON string. Below is a sample output:

```
{"numberInWords":"One hundred and sixty seven thousand five hundred and thirty four"}
```

### Prerequisites:

- AWS account (Free tier account should suffice)
- Terraform installation.

### Installation:

1. Create a tf config file(variables.secret.tf) with below variables
```
variable "aws_access_key" {
  description = "The AWS access key."
  default     = "<YOUR ACCESS KEY>"
}

variable "aws_secret_key" {
  description = "The AWS secret key."
  default     = "<YOUR SECRET KEY>"
}
```
2. Replace `<YOUR ACCESS KEY>` and `<YOUR SECRET KEY>` in above config file with your AWS account access key and secret key.
3. Update value for `region` with your preferred region.
4. To initialize terraform, execute `terraform init` from /terraform directory.
5. To create a plan, execute `terraform plan -out plan.tfplan`
6. To apply plan and create resources, execute `terraform apply plan.tfplan`




