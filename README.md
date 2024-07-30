# Data Generation

## About
TThe main aim of **data generation** is to automate the process of creating resources on AWS using Terraform scripts. This project helps streamline and reduce the time required to set up AWS resources manually. Additionally, with the help of Terraform scripts, we intentionally violate rules for these resources, which will populate Fens resource rules violations dashboard.

## How to Run
You can run the automation using a bash script, `script.sh`. The script takes two parameters: the module to run and the action to perform (plan, apply, or destroy). 

### Example:
```bash
bash script.sh all plan
```
This command will generate a plan for all the resources.

## About the Resources
1. **iam_user (Identity Access Management)**: 
   - Contains `main.tf` that creates resources for IAM users, intentionally violating all the rules.

2. **EC2 (Elastic Cloud Compute)**: 
   - Contains `main.tf` that creates resources for EC2 instances, intentionally violating all the rules.

3. **accounts**: 
   - Contains `main.tf` that creates resources for AWS accounts, intentionally violating all the rules.

4. **aws_vpc**: 
   - Contains `main.tf` that creates resources for AWS VPC, intentionally violating all the rules.

5. **cloud_trail_and_s3_bucket**: 
   - Contains `main.tf` that creates resources for CloudTrail and S3 bucket, intentionally violating all the rules.

6. **kms_key**: 
   - Contains `main.tf` that creates resources for KMS keys, intentionally violating all the rules.

7. **network_acl**: 
   - Contains `main.tf` that creates resources for Network ACLs, intentionally violating all the rules.

8. **rds_instance**: 
   - Contains `main.tf` that creates resources for RDS instances, intentionally violating all the rules.

9. **red_shift_cluster**: 
   - Contains `main.tf` that creates resources for Redshift clusters, intentionally violating all the rules.

10. **security_group**: 
   - Contains `main.tf` that creates resources for Security Groups, intentionally violating all the rules.

## Resources and Rules
For more information on the resources and rules, please refer to this [Google Spreadsheet](https://docs.google.com/spreadsheets/d/1fdv-st9Ivo1X-FbNt5YmpdY3sFzAYbS3fSk4hZU-npk/edit?gid=0#gid=0).

## Benefits
This automation significantly reduces the time required to create AWS resources manually, allowing for faster deployment, management of infrastructure and violate the rules.
