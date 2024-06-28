variable "bolt_input" {
  description = "The access key for the AWS provider"
  type        = string  
  
}
variable "nut_input" {
  description = "The secret key for the AWS provider"
    type        = string

  
}
variable "region" {
  description = "The region in which the resources will be created"
  type        = string
  default     = "us-west-2"
  
}

variable "s3_origin_id" {
  description = "The ID of the S3 origin for the CloudFront distribution"
  type        = string
  default     = "myS3Origin1"
  
}