resource "aws_s3_bucket_object" "file_upload" {
  bucket = "ap-southeast-2.lance.chum.bucket"
  key    = "test.xlsx"
  source = var.file
  etag   = filemd5(var.file)
}
