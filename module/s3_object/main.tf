resource "aws_s3_object" "this" {
  bucket  = var.bucket_name
  key     = var.object_key
  source  = var.source_file
  etag    = filemd5(var.source_file)
  content_type = var.content_type
}