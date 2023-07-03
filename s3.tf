resource "aws_s3_bucket" "purpleops-user-data"{
}

resource "aws_s3_object" "purpleops-user-data"{
	bucket = aws_s3_bucket.purpleops-user-data.id
	key = "dc.ps1"
	source = "./dc.ps1"
	etag = filemd5("./dc.ps1")
}

locals {
  object_s3_uri = "s3://${aws_s3_object.purpleops-user-data.bucket}/${aws_s3_object.purpleops-user-data.key}"
}

resource "aws_iam_role" "purpleops-assumerole" {
  name = "purpleops-assumerole"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy" "s3_policy" {
  name       = "s3_policy"
  role       = "${aws_iam_role.purpleops-assumerole.name}"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = ["s3:Get*", "s3:List*"]
        Effect   = "Allow"
        Resource = [
        "${aws_s3_bucket.purpleops-user-data.arn}",
        "${aws_s3_bucket.purpleops-user-data.arn}/*"
      ]
      },
    ]
  })
}

resource "aws_iam_instance_profile" "purpleops-instance-profile" {
  name = "purpleops-instance-profile"
  role = aws_iam_role.purpleops-assumerole.name
}