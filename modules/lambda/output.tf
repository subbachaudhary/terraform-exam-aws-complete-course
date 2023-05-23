# output "myrole" {
#     lambda_role_arn = aws_iam_role.iam_for_lambda.arn
# }
output "lambda" {
  value = aws_lambda_function.lambda.qualified_arn
}