


# resource "aws_cloudfront_distribution" "cloudfront-1" {
#     origin {
#         domain_name = var.domain_name
#         origin_id   = "S3-${var.s3_origin_id}"
#     }
    
#     enabled = true
#     default_root_object = var.default_root_object
    
#     default_cache_behavior {
#         target_origin_id = "S3-${var.s3_origin_id}"
    
#         viewer_protocol_policy = "redirect-to-https"
#         allowed_methods = ["GET", "HEAD", "OPTIONS"]
#         cached_methods = ["GET", "HEAD", "OPTIONS"]
    
#         forwarded_values {
#         query_string = false
    
#         cookies {
#             forward = "none"
#         }
#         }
    
#         min_ttl = 0
#         default_ttl = 3600
#         max_ttl = 86400
#     }
    
#     restrictions {
#         geo_restriction {
#         restriction_type = "none"
#         }
#     }
    
#     viewer_certificate {
#         cloudfront_default_certificate = true
#     }
    
#     tags = {
#         Environment = "production"
#     }
# }

#creating origin access identity



#create a cloudfront distribution
resource "aws_cloudfront_distribution" "dave-bucket" {
  origin {
    domain_name = var.dns_name
    origin_id   = var.s3_origin_id
  }

  enabled = true
  default_root_object = "index.html"


  default_cache_behavior {
    target_origin_id = var.s3_origin_id

    viewer_protocol_policy = "redirect-to-https"
    allowed_methods = ["GET", "HEAD", "OPTIONS"]
    cached_methods = ["GET", "HEAD", "OPTIONS"]

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    min_ttl = 0
    default_ttl = 3600
    max_ttl = 86400
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }

  tags = {
    Environment = "production"
  }
}