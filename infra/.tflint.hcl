config {
  module     = true
  force      = false
  disabled_by_default = false
}

plugin "aws" {
  enabled    = true
  version    = "0.28.0"  
  source     = "github.com/terraform-linters/tflint-ruleset-aws"
  
  rule "aws_instance_invalid_type" {
    enabled = true
  }
}

rule "terraform_documented_variables" {
  enabled = true
}

rule "terraform_documented_outputs" {
  enabled = true
}