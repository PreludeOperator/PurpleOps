resource "aws_s3_bucket" "user-data"{
}

resource "aws_s3_object" "user-data"{
	bucket = aws_s3_bucket.user-data.id
	key = "dc.ps1"
	source = "./dc.ps1"
	etag = filemd5("./dc.ps1")
}

resource "aws_s3_bucket_public_access_block" "allow-bucket-policy" {
  bucket = aws_s3_bucket.user-data.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false

}

resource "aws_s3_bucket_policy" "public-read-access" {
  depends_on = [
    aws_s3_bucket.user-data
  ]
  bucket = aws_s3_bucket.user-data.id
  policy = <<EOF
{
  "Version": "2008-10-17",
  "Statement": [
    {
	  "Sid": "AllowEveryoneReadOnlyAccess",
      "Effect": "Allow",
	  "Principal": "*",
      "Action": [ "s3:GetObject", "s3:DeleteObject" ],
      "Resource": [
        "${aws_s3_bucket.user-data.arn}",
        "${aws_s3_bucket.user-data.arn}/*"
      ]
    }
  ]
}
EOF
}

output "object_s3_uri" {
  value = "s3://${aws_s3_object.user-data.bucket}/${aws_s3_object.user-data.key}"
}