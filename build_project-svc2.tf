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

    environment_variable {
      name  = "SVC2_REPO"
      value = "${aws_ecr_repository.ECRRepository-svc1.repository_url}"
    }
    environment_variable {
      name  = "SVC2_NAME"
      value = "${aws_ecr_repository.ECRRepository-svc1.name}"
    }
    environment_variable {
      name  = "SVC2_REPO_ID"
      value = "${aws_ecr_repository.ECRRepository-svc1.registry_id}"
    }
  }

  logs_config {
    cloudwatch_logs {
      group_name  = "log-group"
      stream_name = "log-stream"
    }
  }  

  source {
    type            = "CODEPIPELINE"
    buildspec = "buildspec.yml"
  }

  tags = {
    Environment = "svc2"
  }
}
