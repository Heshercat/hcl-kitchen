terraform {
  required_version = ">= 1.6.0"

  required_providers {
    null = {
      source  = "hashicorp/null"
      version = "~> 3.2"
    }
  }

  # Built-in OpenTofu state encryption (encrypted at rest)
  encryption {
    key_provider "pbkdf2" "local" {
      passphrase = var.state_encryption_passphrase

      # Optional, defaults are fine for a simple setup
      # iterations = 200000
      # salt_length = 16
    }

    method "aes_gcm" "default" {
      keys = key_provider.pbkdf2.local
    }

    state {
      method = method.aes_gcm.default
    }

    plan {
      method = method.aes_gcm.default
    }
  }
}

resource "null_resource" "example" {
  triggers = {
    changed_at = timestamp()
  }
}

resource "null_resource" "example2" {
  triggers = {
    changed_at = timestamp()
  }
}

resource "null_resource" "example3" {
  triggers = {
    changed_at = timestamp()
  }
}
