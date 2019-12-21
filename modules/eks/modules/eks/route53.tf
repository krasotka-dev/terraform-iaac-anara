data "aws_elb_hosted_zone_id" "main" {}

resource "aws_route53_record" "api" {
  zone_id = "${var.base_domain_zone_id}"
  name    = "api.${lower(var.environment)}.${var.base_domain}"
  type    = "CNAME"
  ttl     = "60"

  records = [
    "${replace(aws_eks_cluster.this.endpoint, "https://", "")}",
  ]
}