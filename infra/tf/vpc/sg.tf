resource "aws_security_group" "app_servers" {
  name        = "app_servers"
  description = "Allow inbound web traffic"
  vpc_id      = "${module.vpc.vpc_id}"

  ingress {
    description = "Port 80 from world to application servers"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = module.vpc.vpc_cidr_block
  }

  tags = {
    Name = "backend"
  }
}

resource "aws_security_group" "databases" {
  name        = "databases"
  description = "Allow traffic from application SG to databases"
  vpc_id      = "${module.vpc.vpc_id}"

  ingress {
    description = "Port 80 from world to application servers"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = module.vpc.vpc_cidr_block
    security_groups = [aws_security_group.app_servers.id]
  }

  tags = {
    Name = "backend"
  }
}
