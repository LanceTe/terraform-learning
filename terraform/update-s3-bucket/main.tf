locals {
    sandbox = var.environment == "sandbox" ? ["http://localhost:3000", "https://app.sandbox.faethm.ai"] : []
    development = var.environment == "development" ? ["http://localhost:3000", "https://app.development.faethm.ai"] : []
    stage = var.environment == "stage" ? ["https://app.stage.faethm.ai"] : []
    production = var.environment == "production" ? ["https://app.faethm.ai"] : []
    allowedOrigins = coalescelist(local.sandbox, local.development, local.stage, local.production)
}

data "aws_s3_bucket" "buckets" {
    for_each = toset(var.regions)
    bucket   = "${each.key}.lance.chum.bucket"
}

resource "aws_s3_bucket_lifecycle_configuration" "bucket_lifecycle" {
    for_each = toset(var.regions)
    bucket   = data.aws_s3_bucket.buckets[each.key].id

    rule {
        id     = "abort-incomplete-multipart-upload"
        status = "Enabled"
        abort_incomplete_multipart_upload {
            days_after_initiation = 7
        }
    }
}

resource "aws_s3_bucket_cors_configuration" "bucket_cors" {
    for_each = toset(var.regions)
    bucket = data.aws_s3_bucket.buckets[each.key].id

    cors_rule {
        allowed_origins = local.allowedOrigins
        allowed_headers = ["*"]
        expose_headers  = [
            "ETag",
            "x-amz-checksum-sha256"
        ]
        allowed_methods = ["PUT"]
    }
}
