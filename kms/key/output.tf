output "key_id" {
  value = local.key_id
}

output "encrypters" {
  value = google_kms_crypto_key_iam_binding.encrypters
}

output "decrypters" {
  value = google_kms_crypto_key_iam_binding.decrypters
}
