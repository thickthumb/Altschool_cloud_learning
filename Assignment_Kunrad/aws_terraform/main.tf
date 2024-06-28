module "s3_bucket1" {
  source = "./modules/s3_bucket"
  bucket_name = "dave2-bucket"
  acl = "public-read"
#   website {
#     index_document = var.index_document
#     error_document = var.error_document
#   }

}

#creating cloud distribution network

module "cloudfront-1" {
  source = "./modules/cloudfront"
    origin_config = {
        dns_name = module.s3_bucket1.bucket_regional_domain_name
        s3_origin_id  = "myS3Origin1"
    }
    depends_on = [ module.s3_bucket1 ]

}

#create route53 domain and record
# module "route53" {
#   source = "./modules/route53"
#   domain_name_server = "taiwodavid.tech"
#   # cdn_id = module.cloudfront-1.cloudfront_distribution_id
#   name-server = "ns-195.awsdns-24.com"
#   name-server2 = "ns-874.awsdns-45.net"
# }