
# Terraform and Ansible Project

This project uses Terraform to create and configure AWS EC2 instances and Ansible to install and configure web servers (NGINX, HTTPD, IIS) on those instances. Each instance will serve its respective HTML page.

## Table of Contents

1. [Terraform Setup](#terraform-setup)
2. [Ansible Setup](#ansible-setup)
3. [Running the Project](#running-the-project)
4. [Cleanup](#cleanup)

## Terraform Setup

### Files

- `ConfigureRemotingForAnsible.ps1`: Powershell script for configuring remoting on Windows instances.
- `apache2.tpl`: Template file for Apache2 configuration.
- `data.tf`: Terraform data sources.
- `main.tf`: Main Terraform configuration file.
- `outputs.tf`: Terraform output values.
- `terraform.tfvars`: Terraform variables file.
- `user_data.sh.tpl`: User data script template for instance initialization.
- `variables.tf`: Terraform variables definitions.

### Description

The Terraform configuration will:
- Create 3 instances within AWS EC2.
- Generate SSH keys.
- Create Security Groups (SG) and Virtual Private Cloud (VPC).
- Configure a user and prepare the Windows instance for running IIS and a webpage.

### Steps

1. **Initialize Terraform**:
    ```bash
    terraform init
    ```

2. **Plan the Terraform Deployment**:
    ```bash
    terraform plan
    ```

3. **Apply the Terraform Deployment**:
    ```bash
    terraform apply
    ```
</br>
</br>
    
### !!!! in the end of terraform running in the output there will be 3 ip's of each OS, need to put it in the hosts.yml file in ansible before running the playbook. !!!!
</br>
</br>


## Ansible Setup

### Description

The Ansible playbook will:
- Install NGINX, HTTPD, and IIS according to the OS on each instance.
- Deploy an HTML page to each web server.

### Steps

1. **Run the Ansible Playbook**:
    ```bash
    ansible-playbook \
    "/<path to this yml file>/site.yml" \
    -i "/<path to this host yml file>/hosts.yaml" \
    --vault-password-file="/<path to pass file>/pass"
    ```

## Running the Project

1. **Terraform**:
    - Follow the Terraform setup steps to create the infrastructure on AWS.
    
2. **Ansible**:
    - Run the Ansible playbook to configure the web servers and deploy the HTML pages.

## Cleanup

To clean up and remove the infrastructure created by Terraform:

```bash
terraform destroy









  
