

resource "aws_s3_bucket" "bucket" {
  count  = length(var.bucket_names)
  bucket = "${var.bucket_names[count.index]}.${var.domain_name}"
}
resource "aws_s3_bucket_ownership_controls" "bucket_ownership" {
  count = length(var.bucket_names)
  bucket = aws_s3_bucket.bucket[count.index].id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}
resource "aws_s3_bucket_public_access_block" "public_access_block" {
  count  = length(var.bucket_names)
  bucket = aws_s3_bucket.bucket[count.index].id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# resource "aws_s3_bucket_acl" "bucket_acl" {
#   count  = length(var.bucket_names)
#   bucket = aws_s3_bucket.bucket[count.index].id
#   acl    = "public-read"
#   depends_on = [
#     aws_s3_bucket.bucket
#   ]
# }

resource "aws_s3_bucket_acl" "bucket_acl" {
  depends_on = [
    aws_s3_bucket_ownership_controls.bucket_ownership,
    aws_s3_bucket_public_access_block.public_access_block,
  ]
  count = length(var.bucket_names)
  bucket = aws_s3_bucket.bucket[count.index].id
  acl    = "public-read"
}

resource "aws_s3_bucket_policy" "allow_hosting" {
  count  = length(var.bucket_names)
  bucket = "${var.bucket_names[count.index]}.${var.domain_name}"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "AllowPublicAccess"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.bucket[count.index].arn}/*"
      }
    ]
  })

}

resource "aws_s3_bucket_website_configuration" "dashboard_configuration" {
  count  = length(var.bucket_names)
  bucket = aws_s3_bucket.bucket[count.index].id
  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "404.html"
  }
  depends_on = [
    aws_s3_bucket.bucket,
    aws_s3_bucket_acl.bucket_acl
  ]
}
