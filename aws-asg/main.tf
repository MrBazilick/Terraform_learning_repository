# creating launch template for ASG
resource "aws_launch_template" "test-launch" {
  name_prefix            = "test-launch-lt"
  image_id               = var.ami
  instance_type          = var.instance_type
  vpc_security_group_ids = var.vpc_security_group_ids
  key_name               = var.key_pair
}

# Create ASG
resource "aws_autoscaling_group" "asg-test" {
  availability_zones        = ["eu-north-1a"]
  desired_capacity          = 2
  max_size                  = 3
  min_size                  = 2
  health_check_grace_period = 300
  health_check_type         = "ELB"
  force_delete              = true
  termination_policies      = ["OldestInstance"]

  launch_template {
    id      = aws_launch_template.test-launch.id
    version = "$Latest"
  }
}

# Set schedule for asg to increase the scale
resource "aws_autoscaling_schedule" "scale-up" {
  scheduled_action_name  = "scale-up"
  min_size               = 3
  max_size               = 3
  desired_capacity       = 3
  recurrence             = "0 7 * * *" # scale-up at 7:00 UTC0 (and in Ukraine at 9:00 because UTC+2)
  autoscaling_group_name = aws_autoscaling_group.asg-test.name
}

# Set schedule for asg to decrease the scale
resource "aws_autoscaling_schedule" "scale-down" {
  scheduled_action_name  = "scale-down"
  min_size               = 1
  max_size               = 2
  desired_capacity       = 1
  recurrence             = "0 16 * * *" # scale-down at 16:00 UTC0 (and in Ukraine at 18:00 because UTC+2)
  autoscaling_group_name = aws_autoscaling_group.asg-test.name
}