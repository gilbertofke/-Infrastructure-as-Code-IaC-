# Task 5: Infrastructure as Code (IaC) (DevOps and Cloud Engineering)

## Objective

This task aims to use Terraform as the Infrastructure as Code (IaC) tool to define and deploy cloud resources. The resources deployed include:
- Virtual Machine instance
- Networking components (e.g., VPC, subnets)
- Appropriate security configurations

### **Evaluation Criteria:**
- Correct IaC script
- Successful resource deployment
- Proper handling of dependencies and relationships

---

## Step 1: Set up Terraform Configuration

1. **Action**: Created a Terraform configuration file to define cloud resources, including:
   - A Virtual Machine (EC2 instance) on AWS
   - Networking components (VPC, Subnet)
   - Security group for access control
2. **Screenshot**:
   ![Terraform Configuration](./path/to/screenshot1.png)
   _*Caption*: Initial Terraform configuration file that defines an EC2 instance, VPC, subnet, and security group.

---

## Step 2: Initialize Terraform Workspace

1. **Action**: Run `terraform init` to initialize the Terraform workspace.
   - This command installs the required provider plugins, setting up Terraform for resource deployment.
2. **Screenshot**:
   ![Terraform Init](./path/to/screenshot2.png)
   _*Caption*: Initialization process of Terraform in the project directory.

---

## Step 3: Review the Configuration Plan

1. **Action**: Run `terraform plan` to review the plan of action Terraform will take.
   - This ensures that the script is syntactically correct and Terraform correctly understands the desired infrastructure.
2. **Screenshot**:
   ![Terraform Plan](./path/to/screenshot3.png)
   _*Caption*: Review of Terraform plan to ensure resources are correctly defined and dependencies are set.

---

## Step 4: Apply the Terraform Plan

1. **Action**: Run `terraform apply` to deploy the resources defined in the configuration.
   - Terraform reads the configuration, creates the necessary resources, and displays the output for review.
2. **Screenshot**:
   ![Terraform Apply](./path/to/screenshot4.png)
   _*Caption*: Execution of the `terraform apply` command that provisions the EC2 instance, VPC, subnet, and security group.

---

## Step 5: Troubleshooting and Resolving Public IP Issue

1. **Challenge**: After deploying the EC2 instance, I was unable to retrieve the public IP address.
   - Terraform was outputting an empty string for the instance public IP.
   
2. **Solution**: 
   - The issue was due to the fact that the EC2 instance wasn't explicitly configured to request a public IP. 
   - I updated the `aws_instance` resource in the `main.tf` file to include `associate_public_ip_address = true`.
   
   ```hcl
   resource "aws_instance" "vm" {
     ami                      = "ami-0c02fb55956c7d316"  # Ubuntu 20.04 LTS
     instance_type            = "t2.micro"
     subnet_id                = aws_subnet.subnet.id
     security_groups          = [aws_security_group.sg.name]
     associate_public_ip_address = true  # Ensures public IP assignment
     tags = {
       Name = "main-vm"
     }
   }
## Resolution:

After making this change, I ran `terraform apply` again to successfully associate a public IP with the EC2 instance.

**Screenshot:**

_Caption: Successful display of the EC2 instance’s public IP after updating the Terraform script to associate a public IP._

### Step 6: Verify and Output the Public IP

**Action:** Added an output block to the `outputs.tf` file to display the EC2 instance’s public IP.

```hcl
output "instance_public_ip" {
  value = aws_instance.vm.public_ip
}
### Screenshot:

_Caption: Output in the `outputs.tf` file to display the EC2 instance's public IP after deployment._

---

### Step 7: Destroy the Resources (If Required)

**Action:** If any changes were made and we needed to redeploy, I used `terraform destroy` to tear down the resources.

This is a common practice to ensure the environment is cleaned up before reapplying or testing again.

**Command:**

```bash
terraform destroy
### Screenshot:
_Caption: Use of `terraform destroy` to clean up resources when required, ensuring the system is in a pristine state before redeploying._

---

### Step 8: Redeploy and Verify the Infrastructure

**Action:** After making necessary changes or fixes, I redeployed the infrastructure using:

```bash
terraform apply
