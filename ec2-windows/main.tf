provider "aws" {
  access_key = "AKIATU2QSHIIZQC525JS"
  secret_key = "ctR4JSP1rQR7JuTYDd9zLTqlMWSAEBPxQANiL+5s"
  region     = "us-east-1"
}

resource "aws_instance" "example" {
  ami           = "ami-017cdd6dc706848b2"
  instance_type = "t2.micro"
  key_name = "windows"
  vpc_security_group_ids = [aws_security_group.allow_rdp.id]
  subnet_id = module.vpc.public_subnets[0]
}