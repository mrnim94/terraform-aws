resource "aws_s3_bucket" "remote-state" {
  bucket = "terraform-on-aws-eks-nim"

  tags = {
    Description = "Remote state for terraform"
  }
}

resource "aws_dynamodb_table" "remote-state" {
    name = "dev-ekscluster"
    billing_mode = "PAY_PER_REQUEST"
    hash_key       = "LockID"
    attribute {
        name = "LockID"
        type = "S"
    }
}

resource "aws_dynamodb_table" "remote-state-lbc" {
    name = "dev-aws-lbc"
    billing_mode = "PAY_PER_REQUEST"
    hash_key       = "LockID"
    attribute {
        name = "LockID"
        type = "S"
    }
}

resource "aws_dynamodb_table" "dev-eks-irsa-demo" {
    name = "dev-eks-irsa-demo"
    billing_mode = "PAY_PER_REQUEST"
    hash_key       = "LockID"
    attribute {
        name = "LockID"
        type = "S"
    }
}