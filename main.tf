provider "aws" {
  region = "us-east-1"
  profile = "qiross"
}

resource "aws_instance" "fastapi_server" {
  ami           = "ami-0866a3c8686eaeeba"
  instance_type = "t2.micro"
  key_name      = "your-key-pair-name"

  associate_public_ip_address = true
  subnet_id = "subnet-your-subnet-id"

  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update -y
              sudo apt-get install -y docker.io
              sudo systemctl start docker
              sudo systemctl enable docker
              sudo docker run -d -p 80:80 qiross/cdn-fastapi-app:latest
              EOF

  tags = {
    Name = "FastAPI-Server"
  }

  vpc_security_group_ids = [aws_security_group.fastapi_sg.id]
}

resource "aws_security_group" "fastapi_sg" {
  name_prefix = "fastapi-sg-"
  description = "Allow inbound traffic for FastAPI app"
  vpc_id      = "vpc-your-vpc-id"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_cloudfront_distribution" "fastapi_distribution" {
  origin {
    domain_name = aws_instance.fastapi_server.public_dns
    origin_id   = "FastAPIOrigin"

    custom_origin_config {
      http_port                = 80
      https_port               = 443
      origin_protocol_policy   = "http-only"
      origin_ssl_protocols     = ["TLSv1.2"]
    }
  }

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "FastAPIOrigin"

    forwarded_values {
      query_string = true
      cookies {
        forward = "none"
      }
      headers = ["X-Custom-Header"]
    }

    viewer_protocol_policy = "redirect-to-https"

    response_headers_policy_id = aws_cloudfront_response_headers_policy.custom_headers_policy.id
  }

  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }

  depends_on = [aws_instance.fastapi_server]
}

resource "aws_cloudfront_response_headers_policy" "custom_headers_policy" {
  name = "CustomHeadersPolicy"

  custom_headers_config {
    items {
      header   = "X-Custom-Header"
      value    = "Hello from CloudFront"
      override = true
    }
  }
}
