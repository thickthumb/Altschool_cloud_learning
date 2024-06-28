variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}

variable "acl" {
  description = "The ACL (access control list) for the S3 bucket"
  type        = string
  default     = "private"
}

variable "main_document" {
  description = "The index document for the S3 bucket website"
  type        = string
  default     = "index.html"
}

variable "null_document" {
  description = "The error document for the S3 bucket website"
  type        = string
  default     = "error.html"
}

variable "tags" {
  description = "The tags for the S3 bucket"
  type        = map(string)
  default     = {
    Name        = "Static Website Bucket"
    Environment = "Production"
  }
}
variable "domain_name" {
  description = "The domain name of the S3 bucket"
  type        = string
  default = "aws_s3_bucket.static_web_bucket.bucket_regional_domain_name"
  
}
variable "default_root_object" {
  description = "The default root object for the CloudFront distribution"
  type        = string
  default     = "index.html"
  
}

variable "s3_origin_id" {
  description = "The ID of the S3 origin for the CloudFront distribution"
  type        = string
  default     = "myS3Origin1"
  
}
































