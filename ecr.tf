data "aws_ecr_authorization_token" "token" {
}

resource "aws_ecr_repository" "aws_slack_alerting" {

  name                 = "aws_slack_alerting"
  image_tag_mutability = "MUTABLE"


  provisioner "local-exec" {
    command = <<EOF
      docker login ${data.aws_ecr_authorization_token.token.proxy_endpoint} -u AWS -p ${data.aws_ecr_authorization_token.token.password}
      cd images
      docker build -t ${aws_ecr_repository.aws_slack_alerting.repository_url}:latest .
      docker push ${aws_ecr_repository.aws_slack_alerting.repository_url}:latest
      EOF
  }
}