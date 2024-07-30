# Resource to create sqs queue
resource "aws_sqs_queue" "example_queue" {
  name                      = "example-queue"
  delay_seconds             = 90
  max_message_size          = 2048
  message_retention_seconds = 86400
  sqs_managed_sse_enabled   = false
}

# Resource to create sqs policy
resource "aws_sqs_queue_policy" "example_policy" {
  queue_url = aws_sqs_queue.example_queue.id

  policy = jsonencode({
    "Version" : "2008-10-17",
    "Id" : "__default_policy_ID",
    "Statement" : [
      {
        "Sid" : "__owner_statement",
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : "arn:aws:iam::661582458549:root"
        },
        "Action" : "SQS:*",
        "Resource" : "arn:aws:sqs:ap-south-1:661582458549:example-queue"
      },
      {
        "Sid" : "topic-subscription-arn:aws:sns:ap-south-1:661582458549:example-topic",
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : "*"
        },
        "Action" : "SQS:SendMessage",
        "Resource" : "arn:aws:sqs:ap-south-1:661582458549:example-queue",
        "Condition" : {
          "ArnLike" : {
            "aws:SourceArn" : "arn:aws:sns:ap-south-1:661582458549:example-topic"
          }
        }
      }
    ]
  })
}

# Resource to create sns topic subscription
resource "aws_sns_topic_subscription" "user_updates_sqs_target" {
  topic_arn = var.topic_arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.example_queue.arn
}
