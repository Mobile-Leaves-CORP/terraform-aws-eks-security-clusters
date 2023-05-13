resource "aws_route53_zone" "dns" {
  for_each = toset(var.dns_zones)
  name     = each.key

  tags = local.tags
}
