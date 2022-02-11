#
# The main.tf file should only contain terrafrom, provider and backend configurations
#
/*
######################################################
# Google Provider used to create oauth credentials.
# Make sure you choose an appropriate lifetime.
# Using impersonation is a good security practise only
# if you use short linving tokens.
#
provider "google" {
  version = "3.17.0"
  credentials = file("../../../creds/serviceaccount.json")
  alias   = "tokengen"
}

variable "impersonate_service_account" {
  type = string
}

variable "nonprod_folder_name" {
  type = string
}

data "google_service_account_access_token" "sa" {
  provider               = google.tokengen
  target_service_account = var.impersonate_service_account
  lifetime               = "600s"
  scopes = [
    "https://www.googleapis.com/auth/cloud-platform",
  ]
}

######################################################
# Impersonated Google Provider used to create all resources.
#
provider "google" {
  version      = "3.17.0"
  access_token = data.google_service_account_access_token.sa.access_token
}

data "google_client_config" "default" {
  provider = google
}

terraform {
  required_version = "0.13.5" # Allways set a fixed version

  backend "gcs" {
    bucket = "gcs-ch-wabion-1a74-terraform-backend-nonprod"
  }
}
*/
  
####### test file just for fun 
resource "null_resource" "sp" {

  provisioner "local-exec" {
      command = "printf \"hello from terraform folder\""
  }
}


provider "google" {
  project = "etia-5321557420"
  region  = "europe-west2"
}



resource "google_storage_bucket" "bucket" {
  name = "test-bucket-gitactions-1"
  location      = "EU"
  uniform_bucket_level_access = true
  logging {
      log_bucket = "testbucket"
  }

}

