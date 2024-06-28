#create a route53 domain

resource "aws_route53domains_registered_domain" "maindomain" {

  domain_name = var.domain_name_server

  name_server {
    name = var.name-server
  }

  name_server {
    name = var.name-server2
  }

  tags = {
    Environment = "test"
  }
}