output "user_bucket_public_url" {
  value = aws_s3_bucket_website_configuration.dashboard_configuration[0].website_endpoint
}
output "admin_bucket_public_url" {
  value = aws_s3_bucket_website_configuration.dashboard_configuration[1].website_endpoint
}

output "bucket_public_url" {
  value = tomap({
    "${var.bucket_names[0]}-url" = aws_s3_bucket_website_configuration.dashboard_configuration[0].website_endpoint
    "${var.bucket_names[1]}-url" = aws_s3_bucket_website_configuration.dashboard_configuration[1].website_endpoint
  })
}

output "bucket_info" {
  value = tomap({
    "${var.bucket_names[0]}" = aws_s3_bucket.bucket[0]
    "${var.bucket_names[1]}" = aws_s3_bucket.bucket[1]
  })
}

