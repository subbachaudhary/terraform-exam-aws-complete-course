output "cdn_info" {
  value = tomap({
    "${var.bucket_names[0]}" = aws_cloudfront_distribution.s3_dashboard[0]
    "${var.bucket_names[1]}" = aws_cloudfront_distribution.s3_dashboard[1]

  })
}