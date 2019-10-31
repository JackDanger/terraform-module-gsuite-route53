data "aws_route53_zone" "selected" {
  name = "${var.domain}"
}

# Iterate through all enabled services and create subdomains
resource "aws_route53_record" "gsuite" {
  count   = "${length(var.services)}"

  zone_id = "${data.aws_route53_zone.selected.zone_id}"
  name    = "${element(var.services, count.index)}.${var.domain}"

  type    = "CNAME"
  ttl     = "3600"
  records = [ "ghs.googlehosted.com" ]
}

# Add the MX records
resource "aws_route53_record" "mx" {
  zone_id = "${data.aws_route53_zone.selected.zone_id}"
  name    = ""
  type    = "MX"
  ttl     = "3600"
  records = [
    "1 aspmx.l.google.com",
    "5 alt2.aspmx.l.google.com",
    "5 alt2.aspmx.l.google.com",
    "10 alt3.aspmx.l.google.com",
    "10 alt4.aspmx.l.google.com",
  ]
}

# Configure SPF
resource "aws_route53_record" "spf" {
  zone_id = "${data.aws_route53_zone.selected.zone_id}"
  name    = ""
  type    = "SPF"
  ttl     = "3600"
  records = ["v=spf1 include:_spf.google.com ~all"]
}

# Add SPF TXT
resource "aws_route53_record" "txt" {
  zone_id = "${data.aws_route53_zone.selected.zone_id}"
  name    = ""
  type    = "TXT"
  ttl     = "3600"
  records = ["v=spf1 include:_spf.google.com ~all"]
}

# Configure the DKIM TXT for Gmail
resource "aws_route53_record" "_domainkey" {
  zone_id = "${data.aws_route53_zone.selected.zone_id}"
  name    = "google._domainkey"
  type    = "TXT"
  ttl     = "3600"
  records = ["${var.gmail_domainkey}"]
}
