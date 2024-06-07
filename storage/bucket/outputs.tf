output "bucket_names" {
  description = "Names of the created GCS buckets"
  value       = [for bucket in google_storage_bucket.buckets : bucket.name]
}
