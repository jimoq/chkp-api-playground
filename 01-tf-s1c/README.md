# Build simple Check Point policy with IAC using Terraform  

## Environment Setup
1. Deploy a Smart-1 Cloud instance via the [Check Point Infinity Portal](https://portal.checkpoint.com) (demo mode available for 24h).
2. Configure GitHub Codespace secrets:
   - `CHECKPOINT_API_KEY`: Management API key from Smart-1 Cloud > API & SmartConsole
   - `CHECKPOINT_SERVER`: Server FQDN from Web request structure
   - `CHECKPOINT_CLOUD_MGMT_ID`: Cloud management ID from Web request structure
   
   [Here are the instruction on how to add Codespace secrets](https://docs.github.com/en/codespaces/managing-your-codespaces/managing-your-account-specific-secrets-for-github-codespaces#adding-a-secret)

3. Go to **Smart-1 Cloud** > **API & SmartConsole** and generate a Management API key. 
<br> Copy this key to a CHECKPOINT_API_KEY codespace secrets

4. Under the **Web request structure** section you can find the sever **FQDN** and **cloud management ID** for you Smart-1 Cloud service.
   <br>![image](https://github.com/jimoq/chkp-api-playground/assets/44175368/a7b810f9-9dc9-4bb5-8849-a6562307285f)
   * Copy the sever FQDN to the CHECKPOINT_SERVER codespace secret
   * Copy the cloud management ID to the CHECKPOINT_CLOUD_MGMT_ID codespace secrets

5. Launch Codespace and navigate to the `01-tf-s1c` folder.
<br>**Code** > **Codespaces** > **Create codespace on main**
   <br>![image](https://github.com/jimoq/chkp-api-playground/assets/44175368/38e3aa1b-1a68-493b-b380-467d9b2172cc)

## Terraform Structure
The configuration uses multiple provider aliases for different domains and is organized into modules:

### Root Configuration (main.tf, provider.tf, output.tf)
- **Provider Configuration**: Check Point provider with aliases for "system-data-domain" and "user-domain" to manage different domains.
- **Modules**:
  - `module "admins"`: References `./system-data` for administrator and permission setup.
  - `module "policy"`: References `./policy` for security policy objects.
- **Publish Resources**: `checkpoint_management_publish` blocks that trigger on changes to admins or policy modules, and on destroy.
- **Outputs**: Expose generated pod ID and API key (sensitive).

### System-Data Module (./system-data/)
- **Administrator Creation**: Creates "Application-api-Admin" with API key authentication.
- **Permission Profile**: Defines "internet-layer-permissions" with customized access control for policy layers.
- **API Key Generation**: Generates and outputs an API key for the admin.
- **Files**: admins.tf, permission-profile.tf, example-profile.tf

### Policy Module (./policy/)
- **Security Objects**: Defines hosts, networks, services, and policy rules.
- **Random ID**: Generates a unique pod identifier.
- **Outputs**: Pod ID for reference.
- **Files**: hosts.tf, network.tf, tcpservice.tf, rulebase.tf, output.tf, etc.

## Deployment Steps
1. `cd /workspaces/chkp-api-playground/01-tf-s1c/`
2. `terraform init` - Initialize and download providers/modules.
3. `terraform apply` - Review plan (33+ changes) and confirm.
4. Verify changes in Web based Smart Console in Smart-1 Cloud.

## Key Features
- **Multi-Domain Management**: Separate configurations for system and user domains.
- **Automated Publishing**: Changes trigger policy publication.
- **Modular Design**: Reusable modules for admins and policies.
- **API Integration**: Generates API keys for programmatic access.
- **Security**: Sensitive outputs protected.

## Modification and Testing
- Edit files (e.g., change host colors in hosts.tf).
- Run `terraform apply` to update.
- Edit a host resource block to test changes
- Remove a host resource block to test destruction.
- Use `terraform output generated_api_key` to retrieve API key.

This setup demonstrates IaC for Check Point, enabling automated, version-controlled security policy management.

## Next Steps
Proceed to `02-tf-import` for importing existing resources.
```bash
cd /workspaces/chkp-api-playground/02-tf-import/
```

## Scripts
- `publish_s1c.py`: Python script compatible with on-premises management for publishing changes if you run "terraform destroy"
- `publish_python3_S1C.py`: Python script compatible with Smart-1 Cloud API for publishing changes if you run "terraform destroy".

## Clean-up
- `terraform destroy; python3 publish_python3_S1C.py -s user_domain_sid.json; python3 publish_python3_S1C.py -s system_data_domain_sid.json`: command to remove the configuration.

