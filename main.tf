variable "aws_region" {
  default = "us-east-1"
}

variable "workspace" {
    default = "STSGetSessionToken"
}

variable "organization" {
    default = "Darnold-SnowFlake"
}

variable "totp_endpoint" {
	default = "darnold_aws"
}

data "vault_generic_secret" "totp" {
    path = "totp/code/${var.totp_endpoint}"
}

#variable "mfa_token" {
#	type = "string"
#	description = "MFA Device Token"
#}

module "sts_get_session_token" {
    source = "HappyPathway/mfa/aws"
    mfa_token = "${data.vault_generic_secret.totp.data["code"]}"
	# mfa_token = "${var.mfa_token}"
    region = "${var.aws_region}"
}


resource "tfe_variable" "AWS_ACCESS_KEY_ID" {
    key = "AWS_ACCESS_KEY_ID"
    value = "${module.sts_get_session_token.access_key}"
    category = "env"
    workspace_id = "${var.organization}/${var.workspace}"
}

resource "tfe_variable" "AWS_SECRET_ACCESS_KEY" {
    key = "AWS_SECRET_ACCESS_KEY"
    value = "${module.sts_get_session_token.secret_key}"
    category = "env"
    sensitive = true
    workspace_id = "${var.organization}/${var.workspace}"
}

resource "tfe_variable" "AWS_SESSION_TOKEN" {
    key = "AWS_SESSION_TOKEN"
    value = "${module.sts_get_session_token.session_token}"
    category = "env"
    sensitive = true
    workspace_id = "${var.organization}/${var.workspace}"
}

resource "tfe_variable" "AWS_DEFAULT_REGION" {
    key = "AWS_DEFAULT_REGION"
    value = "${var.aws_region}"
    category = "env"
    sensitive = true
    workspace_id = "${var.organization}/${var.workspace}"
}

