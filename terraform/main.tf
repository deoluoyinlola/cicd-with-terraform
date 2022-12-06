terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "eu-central-1"
  access_key = "AKIA52WMJFUL7YM5CFIY"
  secret_key = "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"
}

