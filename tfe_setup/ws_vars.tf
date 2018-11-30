resource "tfe_variable" "instance_type" {
    key = "instance_type"
    value = "m4.large"
    category = "terraform"
    workspace_id = "${module.workspace.workspace_id}"
}

resource "tfe_variable" "instance_name" {
    key = "instance_name"
    value = "MFATest"
    category = "terraform"
    workspace_id = "${module.workspace.workspace_id}"
}

resource "tfe_variable" "key_name" {
    key = "key_name"
    value = "tfe-demos-darnold"
    category = "terraform"
    workspace_id = "${module.workspace.workspace_id}"
}

resource "tfe_variable" "region" {
    key = "region"
    value = "us-east-1"
    category = "terraform"
    workspace_id = "${module.workspace.workspace_id}"
}