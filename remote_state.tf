terraform {
  backend "s3" {
	bucket = "tf-state-remote-zi"
        key = "zoominfo/terraform.tfstate"
        region = "ap-south-1"
  }
}
