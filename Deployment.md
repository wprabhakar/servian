#### Pre requisites
1. Terraform
2. AWS Account Profile Configured on the system where Terraform will be used to create the infrastructure
3. Azure DevOps pipeline is used for continuous deployments

#### Architectural Overview

```
┌---------------┐
|  Web Browser  |
└---------------┘
        ▲               
        |               
        (HTTP)          
        |               
        ▼               
┌---------------┐ 
|      ALB      | => "loadbalancer" security group allows inbound port 80 from 0.0.0.0/0
└---------------┘
        ▲     
        |     
        (HTTP)
        |     
        ▼     
┌-------ECS-----┐
| ┌---Docker--┐ |
| | servian   | |  => "application" security group allows all ports from "loadbalancer" sg 
| └-----------┘ |
└---------------┘
        ▲
        |
        ▼
┌----------------┐ 
| ┌------------┐ |
| | PostgreSQL | |  => "database" security group allows 3306 port from "application" sg
| └------------┘ |
|       RDS      | 
└----------------┘
```


#### Code Improvement

conf.toml contains values to connect to Database.
when using infrastructure as code, the database parameters will be known only after the infrastructure is provisioned.
Using environment variables if present would be best to handle dynamic values.
Program can be modified to load the conf.toml file and then override the values if enviornment variable is present.

#### Infrastructure Provisioning using Terraform
```
cd terraform/AWS
terraform init
terraform apply
```

#### Destroying Infrastructure created in previous step
```
cd terraform/AWS
terraform destroy 
```

#### Automated deployments

In Azure DevOps, create a project "servian"
Initial setup is not straight forward,  here are the highlevel steps
   1. create ecr-push service connection ( use AWS credentials )
   2. integration with github ( Azure DevOps has great toolling and google is your best friend )
Create Build pipeline ( uses azure-pipelines.yml - in the root of this project )
Create Release pipeline ( by referring to the artifacts produced by build job )

#### Screen Dump of setup
Sample screen dump of the running environment can be found in
=> InfrastructureAndAzureDevOpsScreenShots.pdf

