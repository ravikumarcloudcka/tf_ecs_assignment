resource "aws_codebuild_project" "svc2-build-project" {
  name           = "svc2-tf"
  description    = "service2"

  service_role = "${aws_iam_role.build_role.arn}"

  artifacts {
    type                        = "CODEPIPELINE"
  }
  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/amazonlinux2-x86_64-standard:4.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
    privileged_mode = true
  }

  logs_config {
    cloudwatch_logs {
      group_name  = "log-group"
      stream_name = "log-stream"
    }
  }  

  source {
    type            = "CODEPIPELINE"
    git_clone_depth = 1
    buildspec = "buildspec.yml"
  }

  tags = {
    Environment = "svc2"
  }
}
