# Terraform Deployment: Youtube  Test Machine


## Prerequisites
- Have an template created, check this video for easy guide: https://www.youtube.com/watch?v=Ldk0DZfB0Mk
- Terraform installed on your local machine
- Access to a Proxmox server with user and password
- URL for the docuemtnation provider https://registry.terraform.io/providers/bpg/proxmox/latest/docs
- Environment variables configured for authentication as below

## Usage

## Environment Variables
Set up the following environment variables before running Terraform: (set the URL in the provider file)
```
export PROXMOX_VE_USERNAME="username@realm"
export PROXMOX_VE_PASSWORD='password'
```
### Initialize the Project
Run the following command to initialize the Terraform project:
```
terraform init
```

### Plan the Deployment
Use the command below to see a preview of the changes Terraform will apply:
```
terraform plan
```

### Apply the Deployment
Deploy the resources using:
```
terraform apply
```

## Customization
Add any variables specific to the deployment in the `vars.tf` file or pass them as command-line arguments.
