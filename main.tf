# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

module "aft" {
  source = "github.com/aws-ia/terraform-aws-control_tower_account_factory"
  ct_management_account_id    = var.ct_management_account_id
  log_archive_account_id      = var.log_archive_account_id
  audit_account_id            = var.audit_account_id
  aft_management_account_id   = var.aft_management_account_id
  ct_home_region              = var.ct_home_region
  tf_backend_secondary_region = var.tf_backend_secondary_region

  # Terraform configuration
  terraform_distribution = "oss"
  terraform_version      = "1.9.6"

  vcs_provider                                  = "github"
  account_request_repo_name                     = "${var.github_username}/AFT-account-request"
  account_provisioning_customizations_repo_name = "${var.github_username}/AFT-account-provisioning-customizations"
  global_customizations_repo_name               = "${var.github_username}/AFT-global-customizations"
  account_customizations_repo_name              = "${var.github_username}/AFT-account-customizations"

  # Features
  aft_feature_delete_default_vpcs_enabled = false
  aft_feature_cloudtrail_data_events      = false
  aft_feature_enterprise_support          = false

  # Configuration
  aft_enable_vpc                            = true   # The default is true
  aft_vpc_endpoints                         = false
  backup_recovery_point_retention           = 7
  cloudwatch_log_group_retention            = 14
  concurrent_account_factory_actions        = 10
  log_archive_bucket_object_expiration_days = 7
  maximum_concurrent_customizations         = 10
}
