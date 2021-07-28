resource "aws_security_group" "default" {
  name = var.security_group_name
  vpc_id = aws_vpc.default.id

  ingress {
    description = "allow ingress on port 22"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }
  ingress {
    description = "allow ingress on port 80"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "allow ingress on ports 8000-8999"
    from_port = 8000
    to_port = 8999
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description = "allows unlimited egress"
    from_port = 0
    to_port = 0
    protocol = -1
    cidr_blocks = ["0.0.0.0/0"]
  } 
}

resource "aws_security_group" "chefserver" {
  name        = "chefserver_sg"
  description = "Security Group for chefserver"
  vpc_id      = aws_vpc.default.id

  # Allow inbound HTTPS traffic 
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow inbound HTTP traffic 
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow inbound SSH traffic
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# resource "aws_security_group" "mysql" {
#   name        = "mysql_server_sg"
#   description = "Security Group for database server"
#   vpc_id      = aws_vpc.default.id

#   # Allow inbound TCP connection for MySql from instances from the public subnet
#   ingress {
#     from_port   = 3306
#     to_port     = 3306
#     protocol    = "tcp"
#     cidr_blocks = ["10.0.1.0/24"]
#   }

#   # Allow inbound TCP connection for MySql from instances from the private subnet
#   ingress {
#     from_port   = 3306
#     to_port     = 3306
#     protocol    = "tcp"
#     cidr_blocks = ["10.0.100.0/24"]
#   }

#   # outbound internet access
#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }

# resource "aws_security_group" "web" {
#   name        = "web_server_sg"
#   description = "Security Group for webserver"
#   vpc_id      = aws_vpc.default.id

#   # Allow inbound HTTP connection from all
#   ingress {
#     from_port   = 80
#     to_port     = 80
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   # outbound internet access
#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }


