# Configure Route53 records for GSuite

## Usage

Add something like the following to your terraform code and run `terraform
init` to download this module from GitHub.

```
module "gsuite" {
  source = "github.com/JackDanger/terraform-module-gsuite-route53"

  domain = "example.com"

  # Add the DKIM config from Google. Note the escaped double quotes only in the
  middle, as per https://github.com/hashicorp/terraform/issues/10048
  gmail_domainkey = "v=DKIM1; k=rsa; p=A-long-Base64-encoded-string\" \"and-another-long-string""

  # Each of these will have a subdomain configured for them,
  # e.g. 'calendar.example.com' -> GSuite Calendar
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
