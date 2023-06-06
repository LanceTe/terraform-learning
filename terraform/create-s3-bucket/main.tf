resource "aws_s3_bucket" "buckets" {
  for_each = toset(var.regions)
  bucket   = "${each.key}.lance.chum.bucket"
}
