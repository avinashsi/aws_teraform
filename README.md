Terraform setup on AWS
=========

Getting started
---------------
Note: This Poc is done on Windows10 .

Before doing git pull do the following necessary steps first.

Install terraform on Windows10
1. Download terraform from following url

https://releases.hashicorp.com/terraform/0.11.11/terraform_0.11.11_windows_amd64.zip
unzip terraform to a folder and add terraform to your path variable in Windows.

2. Ensure the path has been successfully added by running the following command.

terraform -v

3. Now you are ready to go download the code by running the following command.

```
git clone https://github.com/avinashsi/aws_teraform.git
```

4. Ensure aws-cli is configured on you system and the configurations are saved in place.

Terraform will automatically search for saved API credentials in ~/.aws/credentials or IAM instance profile credentials:

[default]
aws_access_key_id = B...T
aws_secret_access_key = 8...Z

5. Now browse inside the directory of where you have checked out the code.
Run the following command

```
terraform init
```
This will install the Teraform aws plugin which provisions services on aws.

6. Now in-order to provision infrastructure on aws run the following command
Also ensure you have keypair handy which you will use to login in the ec2 instances.
```
terraform plan
```

The above will show what services will be fired up when you run the below command.

```
terraform apply
```

Please refer the attached log in to see the [o/p](https://raw.githubusercontent.com/avinashsi/aws_teraform/master/Application_creation.log)

7. The below infrastructure can be destroyed in one step. by following command

```
terraform destroy
```

Please refer the attached log in to see the [o/p](https://raw.githubusercontent.com/avinashsi/aws_teraform/master/application_destroy.log)



Detailed Steps Explained Below.
===

Summary
This packages includes ELB and two ec2 instances in which HelloWorld application is running
inside docker container which is being provisioned by [shell-script](https://raw.githubusercontent.com/avinashsi/aws_teraform/master/userdata.sh) when the ec2 instances comes up.

When you run terraform apply it prompts of SSH keypair
Please make sure the ssh key pair is already present. enter that ssh key pair which we will use to
get acess on ec2_instacnes

```
var.key_name
  Name of the SSH keypair to use in AWS.

  Enter a value:

```

Define zone in connection.tf file which we will use to fire-up the infrastructure

```
provider "aws" {
  region = "${var.aws_region}"
}
```

Define variables.tf file to define variabes inside it. Below is the exapmple

```
variable "aws_amis" {
  default = {
    "us-west-2" = "ami-01e24be29428c15b2"
    }
```
Defined Networking in [network.tf](https://raw.githubusercontent.com/avinashsi/aws_teraform/master/network.tf) file which contains definition of vpc, security_groups, subnets, aws_route_table dtl etc.
Below is the example.

Here we have ensured the security_groups associated with ec2 instances have port 80
opened only for security_groups associated with elb and not be acessed from outside world.

```
resource "aws_security_group" "default" {
  name        = "ec2_sg"
  description = "Used in the terraform"
  vpc_id      = "${aws_vpc.default.id}"

  # HTTP access from elb_security_group only
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups = ["${aws_security_group.elb.id}"]

  }
```

Define ec2 settings and provisioning in following file [ec.tf](https://raw.githubusercontent.com/avinashsi/aws_teraform/master/ec2.tf)

in below example we have provisioned only two

```
ami = "${lookup(var.aws_amis, var.aws_region)}"
count = 2
```

Now provisioning elb. We have ensured you can add as much ec2 instacnces in
the background we will ensure all the traffic get's routed from elb.
```
# The instance is registered automatically

instances                   = ["${aws_instance.web.*.id}"]
cross_zone_load_balancing   = true
idle_timeout                = 400
connection_draining         = true
connection_draining_timeout = 400
}

```


You can get the o/p of elb url on console once the terraform apply command runs successfully
as shown.

```
Outputs:

address = hello-elb-1607032391.us-west-2.elb.amazonaws.com

```
Go the browser and enter the following url
hello-elb-1607032391.us-west-2.elb.amazonaws.com
as shown in following screenshot to access the application.
![alt text](https://raw.githubusercontent.com/avinashsi/aws_teraform/master/hello_world.png)



In order to destroy the services created on aws run the following command

```
terraform destroy
```
Enter the key value pair which you used to access ec2 instances and then
review the resource which are going to be destroyed and press yes if you are happy
to destroy those services
