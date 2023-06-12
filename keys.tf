resource "aws_key_pair" "key" {
  key_name   = "ssh-key"
  public_key = var.ssh_public_key
}
