variable "domain" {
  description = "The human-readable name of the domain to be configured"
}

variable "gmail_domainkey" {
  description = "The two strings, each in double quotes, that Google offers for DKIM signing"
}

variable "services" {
  description = "The list of GSuite services to create subdomains for"
  default = []
}
