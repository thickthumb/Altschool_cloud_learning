# resource "aws_s3_bucket_website_configuration" "dave1-bucket-config" {
#   bucket = aws_s3_bucket.dave1-bucket.id
#   depends_on = [ aws_s3_bucket.dave1-bucket ]
#  }

resource "aws_s3_bucket" "dave1-bucket" {
  bucket = var.bucket_name
  

  tags = {
    Name        = "Static Website Bucket"
    Environment = "Production"
  }
  
  website {
    index_document = var.main_document
    error_document = var.null_document
  }
}

# resource "aws_s3_bucket" "dave1-bucket" {
#   bucket = aws_s3_bucket_website_configuration.dave1-bucket.bucket

#   tags = {
#     Name        = "Static Website Bucket"
#     Environment = "Production"
#   }
# }

# resource "aws_s3_bucket_acl" "static_web_bucket_acl" {
#   bucket = aws_s3_bucket.dave1-bucket.id
#   acl    = "private"
# }

locals {
  s3_origin_id = "myS3Origin1"
}

resource "aws_s3_object" "object1" {
  bucket = aws_s3_bucket.dave1-bucket.id
  key    = "index.html"
  source = "./index.html"

  
}
resource "aws_s3_object" "object2" {
  bucket = aws_s3_bucket.dave1-bucket.id
  key    = "error.html"
  source = "./error.html"


}

resource "aws_cloudfront_origin_access_identity" "origin_access_identity" {
  comment = "Origin Access Identity for web bucket"
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.dave1-bucket.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          AWS = aws_cloudfront_origin_access_identity.origin_access_identity.iam_arn
        }
        Action = "s3:GetObject"
      Resource = [

        "${aws_s3_bucket.dave1-bucket.arn}/*"
        ]
      }
    ]
  })
}


