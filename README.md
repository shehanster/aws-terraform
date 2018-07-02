
##     Simple Terraform provissioning script based on getting a 2 node setup to run wso2 api manager 2.x    


1.Add key pair from aws to folder key

2.Add your aws credentials to the terraform.tfvars and change name of the key

3.Add network cidr's and subnets in the network main

4.Add the AMI image ID's depending on the image you want and the region





Structure
```
├── instances
│   ├── main.tf
│   ├── outputs.tf
│   ├── user_data
│   └── variables.tf
├── key
├── main.tf
├── network
│   ├── main.tf
│   ├── outputs.tf
│   ├── sg_groups.tf
│   └── variables.tf
├── outputs.tf
├── README.md
├── scripts
├── terraform.tfvars
└── variables.tf
```


Database module for RDS and ELB attaching the instances yet to come. 

