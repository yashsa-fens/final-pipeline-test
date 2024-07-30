# Resource to create sns topic
resource "aws_sns_topic" "example_topic" {
  name = "example-topic"
}

# Resource to create sns topic policy 
resource "aws_sns_topic_policy" "example_policy" {
  arn = aws_sns_topic.example_topic.arn

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "SnsIAMTopicPolicy",
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "events.amazonaws.com"
        },
        "Action" : "sns:Publish",
        "Resource" : "${aws_sns_topic.example_topic.arn}"
      },
      {
        "Sid" : "AllowAccessToTopicOwner",
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : "*"
        },
        "Action" : [
          "sns:Subscribe",
          "sns:ListSubscriptionsByTopic",
          "sns:Publish",
          "sns:Receive"
        ],
        "Resource" : "${aws_sns_topic.example_topic.arn}",
        "Condition" : {
          "StringEquals" : {
            "AWS:SourceOwner" : "661582458549"
          }
        }
      }
    ]
  })
}

# It will print topic arn to console
output "topic_arn" {
  value = aws_sns_topic.example_topic.arn
}
