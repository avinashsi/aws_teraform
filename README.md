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

```
terraform plan
```

The above will show what services will be fired up when you run the below command.

```
terraform apply
```

Please refer the attached log in to see the 
