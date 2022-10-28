resource "aws_codebuild_project" "svc1-build-project" {
  name           = "svc1-tf"
  description    = "service1"

  service_role = "${aws_iam_role.build_role.arn}"

  artifacts {
    type                        = "CODEPIPELINE"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/amazonlinux2-x86_64-standard:4.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
    privileged_mode  = true
    
    environment_variable {
      name  = "SVC1_REPO"
      value = "${aws_ecr_repository.ECRRepository-svc2.repository_url}"
    }
    environment_variable {
      name  = "SVC1_NAME"
      value = "${aws_ecr_repository.ECRRepository-svc2.name}"
    }
    environment_variable {
      name  = "SVC1_REPO_ID"
      value = "${aws_ecr_repository.ECRRepository-svc2.registry_id}"
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
    Environment = "svc1"
  }
}
