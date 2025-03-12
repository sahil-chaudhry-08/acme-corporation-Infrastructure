# Acme Corporation Infrastructure

## Prerequisites
Before deploying the application, ensure you have the following:

### Azure Account:

- An active Azure subscription.

- A service principal created in Microsoft Entra ID with client secret is generated which is later stored in GitHub secrets

- Creating a role assignment i.e. assigning Contributor role to the service principal on the Azure subscription

- Creating a Storage account and container inside it to store the terraform state file with access key stored in GitHub secrets

### Terraform:

- Terraform installed on your local machine if required.

### GitHub Repository:

A GitHub repository with the following secrets configured:

  - `AZURE_CLIENT_ID`
  - `AZURE_CLIENT_SECRET`
  - `AZURE_SUBSCRIPTION_ID`
  - `AZURE_TENANT_ID`
  - `AZURE_STORAGE_ACCOUNT_NAME`
  - `AZURE_STORAGE_CONTAINER_NAME`
  - `AZURE_STORAGE_ACCESS_KEY`
  - `RESOURCE_GROUP_NAME`

### Repository Structure

```repository/
├── README.md
├── frontend-app-service.tf
├── keyvault.tf
├── middleware-app-service.tf
|── networking.tf
|── nsg.tf
|── provider.tf
│── resourcegroup.tf
├── service-plan.tf
├── sql.tf
├── terraform.tfvars
├── variable.tf
└── .github/
    └── workflows/
        └── terraform.yaml
```

  ## Testing the automated Flow

1. **Push terraform Changes**:
   - Push terraform code to the main branch to trigger the terraform GitHub Actions workflow.

2. **Monitor Workflow**:
   - Go to the Actions tab in your GitHub repository to monitor the workflow.

3. **Verify the terraform deployment**:
   - After the workflow completes, verify that infrastructure is created in Azure
