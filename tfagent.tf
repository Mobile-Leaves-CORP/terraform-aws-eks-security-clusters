data "aws_ami" "tfagent" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_security_group" "tf_agent" {
  name_prefix = "tf-agent"
  vpc_id      = module.vpc.vpc_id


  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [module.eks.node_security_group_id] # only cluster nodes
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = local.tags
}

resource "aws_instance" "agent" {
  count                  = var.tfc_agent_token != "" ? 1 : 0
  ami                    = data.aws_ami.tfagent.id
  instance_type          = "t3.micro"
  subnet_id              = module.vpc.private_subnets[0]
  user_data              = templatefile("${path.module}/template/userdata_tfagent.tpl", { TFC_AGENT_TOKEN = var.tfc_agent_token, TFC_AGENT_NAME = var.tfc_agent_name })
  tags                   = local.tags
  vpc_security_group_ids = [aws_security_group.tf_agent.id]
}
