output "bucket_regional_domain_name" {
  value = aws_s3_bucket.dave1-bucket.bucket_regional_domain_name
  description = "value of the bucket regional domain name"
}