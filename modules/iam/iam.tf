# IAM Role
resource "aws_iam_instance_profile" "profile" {
  name = aws_iam_role.iam.name
  role = aws_iam_role.iam.name
}


resource "aws_iam_role" "iam" {
  name               = "${var.project}-${var.env}-iam"
  assume_role_policy = data.aws_iam_policy_document.ec2_assume_role.json
}

data "aws_iam_policy_document" "ec2_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

  }
}

resource "aws_iam_role_policy_attachment" "ssm_full" {
  role       = aws_iam_role.iam.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMFullAccess"
}
