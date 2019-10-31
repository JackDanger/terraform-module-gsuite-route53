output "subdomains" {
  value = "${join(",", var.services)}"
}

output "domain" {
  value = "${var.domain}"
}
