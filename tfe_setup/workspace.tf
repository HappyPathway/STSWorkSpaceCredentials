variable "organization" {
    type="string"
    description="Name of Terraform Enterprise Organization"
}


variable "github_org" {
    type="string"
    description="Github Organization"
    default="HappyPathway"
}


variable "vault_token" {
    type="string"
    description="Vault Token"
}


variable "vault_addr" {
    type="string"
    description="Vault Cluster Address"
}


variable "repo_name" {
    type="string"
    description="Name of Github Repo"
    default = "terraform-aws-ec2-instance"
}


variable "workspace_name" {
    type="string"
    description="Name of TFE Workspace"
}


module "workspace" {
    source  = "app.terraform.io/Darnold-Hashicorp/demo-workspace/tfe"
    version = "2.3.1"
    github_org = "${var.github_org}"
    oauth_token = "${module.oauth_token.oauth_token}"
    organization = "${var.organization}"
    repo_name = "${var.repo_name}"
    workspace_name ="${var.workspace_name}"
    aws_vars = false
    aws_role = "ec2_admin"
    azure_vars = false
    gcp_vars = false
    vault_vars = true
    vault_addr = "${var.vault_addr}"
    vault_token = "${var.vault_token}"
    create_repo = false
}
output "workspace_id" {
    value = "${module.workspace.workspace_id}"
    }