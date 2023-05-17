resource "aws_cognito_user_pool" "pool" {
  name = "${var.project_name}-${var.env}-pool"

  username_attributes      = ["email"]
  auto_verified_attributes = ["email"]
  account_recovery_setting {
    recovery_mechanism {
      name     = "verified_email"
      priority = 1
    }
  }

}