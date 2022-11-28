# instance
data "aws_ssm_parameter" "amzn2_ami" {
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

resource "aws_instance" "ec2" {
  ami           = data.aws_ssm_parameter.amzn2_ami.value
  instance_type = "t2.micro"
  subnet_id     = var.private_subnet_1c_id

  iam_instance_profile = var.profile_name

  tags = {
    Name = "${var.project}-${var.env}-ec2"
  }
}
