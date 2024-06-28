variable "origin_config" {
  description = "The configuration for the CloudFront origin"
  type        = map(string)
  
  
}
variable "s3_origin_id" {
  description = "The ID of the S3 origin for the CloudFront distribution"
  type        = string
  default     = "myS3Origin1"
  
}
variable "dns_name" {
  description = "The domain name of the S3 bucket"
  type        = string
  default = "dave-bucket.s3.amazonaws.com"
  
}