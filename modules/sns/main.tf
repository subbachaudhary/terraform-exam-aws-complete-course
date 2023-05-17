locals {
  email = ["subba.chaudhary@wesionary.team", "manip.poudel@wesionary.team"]
}
# resource "aws_sns_topic" "demo-topic"{
#     name    = var.billing_alert
# }
resource "aws_sns_topic" "billing_alert"{
    name    = var.billing_alert
 }

resource "aws_sns_topic_policy" "demo-policy" {
  arn = aws_sns_topic.billing_alert.arn
  policy = data.aws_iam_policy_document.sns_topic_policy.json
}
data "aws_iam_policy_document" "sns_topic_policy" {
  policy_id = "__default_policy_ID"

  statement {
    actions = [
      "SNS:Publish",
        "SNS:RemovePermission",
        "SNS:SetTopicAttributes",
        "SNS:DeleteTopic",
        "SNS:ListSubscriptionsByTopic",
        "SNS:GetTopicAttributes",
        "SNS:AddPermission",
        "SNS:Subscribe"
    ]
    # "resouce" : "arn:aws:sns:us-east-1:530349173736:",
    # condition {
    #   "StringEquals": {
    #       "AWS:SourceOwner": "530349173736"
    #     }
    # }

    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    resources = [
      aws_sns_topic.billing_alert.arn,
    ]

    sid = "__default_statement_ID"
  }
}


resource "aws_sns_topic_subscription" "email_subscription" {
  count = length(local.email)  
  topic_arn = aws_sns_topic.billing_alert.arn
  protocol  = "email"
  #endpoint  = "subba.chaudhary@wesionary.team"
  endpoint = local.email[count.index]

}