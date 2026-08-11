## demo-module-02
In this folder there are 4 modules
1) test-internet-gateway :- It create Internet gateway.
2) test-route-table :- It create route table and route table association.
3) test-subnet :- It Create Subnet
4) test-vpc :- It create VPC

# Execution process
1) clone directory
2) Create terraform.tfvars file with values for variables 
    2.1) Working Dir:-  \Accure_terraform\demo-module-02
3) Run `terraform init` Command
    3.1) Working Dir :- \Accure_terraform\
4) run `terraform validate` Command ( to check any errors)
    4.1) Working Dir :- \Accure_terraform\
5) run `terraform plan` Command
    5.1) Working Dir :- \Accure_terraform\
6) run `terraform apply` Command
    6.1) Working Dir :- \Accure_terraform\

Check the output and resources are created
### In output you will get Ids of Internet Gateway, Route Table, Subnet and VPC on display

### Note :- After practice don't forget to destroy infrs using `terraform destroy` command
 Working Dir :- \Accure_terraform\

