resource "aws_codestarconnections_connection" "github_act" {
  name          = "ravikumarcloudcka"
  provider_type = "GitHub"
}

resource "aws_s3_bucket" "codepipeline_bucket" {
  bucket = "code-pipeline-svc"
}

resource "aws_codepipeline" "CodePipelinePipeline" {
    name = "zoominfo_svc1"
    role_arn = "${aws_iam_role.code_pipeline_role.arn}"
    artifact_store {
        location = "${aws_s3_bucket.codepipeline_bucket.bucket}"
        type = "S3"
    }
    stage {
        name = "Source"
        action {
                name = "Source"
                category = "Source"
                owner = "AWS"
                configuration = {
                    BranchName = "main"
                    ConnectionArn = "${aws_codestarconnections_connection.github_act.arn}"
                    FullRepositoryId = "ravikumarcloudcka/svc1-tf"
                    OutputArtifactFormat = "CODE_ZIP"
                }
                provider = "CodeStarSourceConnection"
                version = "1"
                output_artifacts = [
                    "SourceArtifact"
                ]
                run_order = 1
            }
    }
    stage {
        name = "Build"
        action {
                name = "Build"
                category = "Build"
                owner = "AWS"
                configuration = {
                    ProjectName = "${aws_codebuild_project.svc1-build-project.name}"
                }
                input_artifacts = [
                    "SourceArtifact"
                ]
                provider = "CodeBuild"
                version = "1"
                output_artifacts = [
                    "BuildArtifact"
                ]
                run_order = 1
            }
    }
    stage {
        name = "Deploy"
        action {
                name = "Deploy"
                category = "Deploy"
                owner = "AWS"
                configuration = {
                    ClusterName = "assignment"
                    FileName = "imagedefinitions.json"
                    ServiceName = "service1"
                }
                input_artifacts = [
                    "BuildArtifact"
                ]
                provider = "ECS"
                version = "1"
                run_order = 1
            }
    }
}

resource "aws_codepipeline" "CodePipelinePipeline2" {
    name = "zoominfo_svc2"
    role_arn = "${aws_iam_role.code_pipeline_role.arn}"
    artifact_store {
        location = "${aws_s3_bucket.codepipeline_bucket.bucket}"
        type = "S3"
    }
    stage {
        name = "Source"
        action {
                name = "Source"
                category = "Source"
                owner = "AWS"
                configuration = {
                    BranchName = "main"
                    ConnectionArn = "${aws_codestarconnections_connection.github_act.arn}"
                    FullRepositoryId = "ravikumarcloudcka/svc2-tf"
                    OutputArtifactFormat = "CODE_ZIP"
                }
                provider = "CodeStarSourceConnection"
                version = "1"
                output_artifacts = [
                    "SourceArtifact"
                ]
                run_order = 1
            }
    }
    stage {
        name = "Build"
        action {
                name = "Build"
                category = "Build"
                owner = "AWS"
                configuration = {
                    ProjectName = "${aws_codebuild_project.svc2-build-project.name}"
                }
                input_artifacts = [
                    "SourceArtifact"
                ]
                provider = "CodeBuild"
                version = "1"
                output_artifacts = [
                    "BuildArtifact"
                ]
                run_order = 1
            }
    }
    stage {
        name = "Deploy"
        action {
                name = "Deploy"
                category = "Deploy"
                owner = "AWS"
                configuration = {
                    ClusterName = "assignment"
                    FileName = "imagedefinitions.json"
                    ServiceName = "service2"
                }
                input_artifacts = [
                    "BuildArtifact"
                ]
                provider = "ECS"
                version = "1"
                run_order = 1
            }
    }
}
