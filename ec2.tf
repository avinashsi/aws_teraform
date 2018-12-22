resource "aws_instance" "web" {
  instance_type = "t2.micro"
  # Lookup the correct AMI based on the region
  # we specified
  ami = "${lookup(var.aws_amis, var.aws_region)}"
  count = 2

  # The name of our SSH keypair you've created and downloaded
  # from the AWS console.
  #
  # https://console.aws.amazon.com/ec2/v2/home?region=us-west-2#KeyPairs:
  #
  key_name = "${var.key_name}"
  # Our Security group to allow HTTP and SSH access
  vpc_security_group_ids = ["${aws_security_group.default.id}"]
  subnet_id              = "${aws_subnet.tf_test_subnet.id}"
  user_data              = "${file("userdata.sh")}"

  #Instance tags
  tags {
    Name = "HelloWorld"
  }

}
