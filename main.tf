module "template_files" {
    source = "hashicorp/dir/template"

    base_dir = "${path.module}/website"
}

resource "aws_s3_bucket" "hosting_bucket" {
  bucket = var.s3_bucket_name
}

resource "aws_s3_bucket_public_access_block" "hosting_bucket_public_access_block" {
  bucket = aws_s3_bucket.hosting_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "hosting_bucket_policy" {
    bucket = aws_s3_bucket.hosting_bucket.id

    policy = jsonencode({
        "Version": "2012-10-17",
        "Statement": [
            {
                "Sid": "PublicRead",
                "Effect": "Allow",
                "Principal": "*",
                "Action": [
                    "S3:GetObject",
                    "S3:GetObjectVersion"
                ],
                "Resource": "arn:aws:s3:::${var.s3_bucket_name}/*"
            }
        ]
    })

    depends_on = [ aws_s3_bucket_public_access_block.hosting_bucket_public_access_block ]
}

resource "aws_s3_bucket_website_configuration" "hosting_bucket_website_configuration" {
    bucket = aws_s3_bucket.hosting_bucket.id

    index_document {
        suffix = "index.html"
    }
}

resource "aws_s3_object" "hosting_bucket_files" {
    bucket = aws_s3_bucket.hosting_bucket.id

    for_each = module.template_files.files

    key = each.key
    content_type = each.value.content_type

    source = each.value.source_path
    content = each.value.content

    etag = each.value.digests.md5
}