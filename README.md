# Configure Route53 records for GSuite

## Usage:

```
module "gsuite" {
  source  = "JackDanger/terraform-module-gsuite-route53"

  domain = "example.com"
  gmail_domainkey = <<-EODKIM
"v=DKIM1; k=rsa; p=AVERYLONGSTRING" "ANDANOTHER"
EODKIM

  # Each of these will have a subdomain configured for them
  services = [
    "calendar",
    "docs",
    "drive",
    "groups",
    "hangouts",
    "mail",
    "sheets"
  ]
}
```
