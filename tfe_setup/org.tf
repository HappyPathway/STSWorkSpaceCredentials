resource "tfe_organization_token" "token" {
    organization = "${var.organization}"
}

module "oauth_token" {
    source = "github.com/HappyPathway/terraform-tfe-oauth-token"
    tfe_org = "${var.organization}"
    tfe_token = "${tfe_organization_token.token.token}"
}