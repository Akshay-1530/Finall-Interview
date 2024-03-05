terraform {
  backend "s3" {
    bucket = "my-terraformproject02"
    key = "main"
    region = "us-east-1"
    dynamodb_table = "my-dynamodbtable"
  }
}
