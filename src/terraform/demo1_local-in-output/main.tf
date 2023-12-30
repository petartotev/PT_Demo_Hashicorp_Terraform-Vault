terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

##################################################################################
# PROVIDERS
##################################################################################

# If provider doesn't have configuration options in the provider block - we can skip it, as there is nothing to configure.
# Ergo, the provider below could be removed, but I left it for explicit clarity.
provider "random" {
  # No configuration with this provider plugin...
}

##################################################################################
# RESOURCES
##################################################################################

resource "random_integer" "random_int" {
  min = 1
  max = 100
}