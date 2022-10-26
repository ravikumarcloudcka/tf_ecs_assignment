resource "aws_s3_bucket" "s3_build" {
  bucket = "codepipeline-svc"
}

resource "aws_s3_bucket_acl" "s3-build-acl" {
  bucket = aws_s3_bucket.s3_build.id
  acl    = "private"
}
