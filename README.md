#########################################################################
##     Simple Terraform prvissioning script based on my work in wso2   ##
#########################################################################











1.Add key pair from aws to folder key

2.Add your aws credentials to the terraform.tfvars and change name of the key

3.Add network cidr's and subnets in the networm module and main



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

