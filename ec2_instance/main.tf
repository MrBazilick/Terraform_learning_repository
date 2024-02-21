# Instance profile with secret manager permissions
resource "aws_iam_role" "secret_test_role" {
  name = "secret_test_role"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

# IAM Policy Attachment (AWS-managed policy example)
resource "aws_iam_role_policy_attachment" "secrets_manager_rw_test" {
  role       = aws_iam_role.secret_test_role.name
  policy_arn = "arn:aws:iam::aws:policy/SecretsManagerReadWrite"
}

# Instance Profile
resource "aws_iam_instance_profile" "sm_rw_test_profile" {
  name = "example_profile"
  role = aws_iam_role.secret_test_role.name
}

# secret creation:
data "aws_secretsmanager_random_password" "test1" {
  password_length            = 50
  require_each_included_type = true
}

resource "aws_secretsmanager_secret" "learn_secret" {
  description = "Practice with aws secret manager"
  name        = "learn_secret2"
}

resource "aws_secretsmanager_secret_version" "learn_secret" {
  secret_id     = aws_secretsmanager_secret.learn_secret.id
  secret_string = data.aws_secretsmanager_random_password.test1.id
}

# Instance launch
resource "aws_instance" "terraform_lerning" {
  ami                         = var.ami
  instance_type               = var.instance_type
  key_name                    = var.key_pair
  associate_public_ip_address = true
  user_data                   = file("${path.module}/script.sh")
  vpc_security_group_ids      = var.vpc_security_group_ids
  iam_instance_profile  = aws_iam_instance_profile.sm_rw_test_profile.name

 tags = {
    Terraform   = "true"
    Environment = "test"
  }
# if I need to write userdata inside tf recource. leave this for example) 
# user_data = <<-EOF
#EOF
}