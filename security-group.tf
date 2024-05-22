# Create a security group
resource "aws_security_group" "allow_redis" {
  name        = "roboshop-${var.ENV}-redis-sg"
  description = "Allow Redis internal inbound traffic"
  vpc_id = data.terraform_remote_state.vpc.outputs.VPC_ID

  # Inbound rules
  ingress {
    description = "Allow Elastic Cache from local network"
    from_port   = 6379
    to_port     = 6379
    protocol    = "tcp"
    cidr_blocks = [data.terraform_remote_state.vpc.outputs.DEFAULT_VPC_CIDR]
  }

    ingress {
    description = "Allow Elastic Cache from local network"
    from_port   = 6379
    to_port     = 6379
    protocol    = "tcp"
    cidr_blocks = [data.terraform_remote_state.vpc.outputs.VPC_CIDR]
  }

  # Outbound rules
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "roboshop-${var.ENV}-redis-sg"
  }
}