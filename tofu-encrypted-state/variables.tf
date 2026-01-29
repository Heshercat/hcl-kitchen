variable "state_encryption_passphrase" {
  description = "Passphrase used to encrypt/decrypt the OpenTofu state."
  type        = string
  sensitive   = true
}
