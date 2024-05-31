# Build simple Check Point policy with IAC using Terraform  

## Prepare the enviroment

1. Login in to your infinity account https://portal.checkpoint.com and deploy a new Smart-1 Cloud application, you can select demo for a 24h runtime.

2. You need to add the following Codespace secrets to you github account and connect them to your repository.
   <br>Here are the instruction on how to add Codespace secrets: https://docs.github.com/en/codespaces/managing-your-codespaces/managing-your-account-specific-secrets-for-github-codespaces#adding-a-secret
   * CHECKPOINT_API_KEY 
   * CHECKPOINT_SERVER
   * CHECKPOINT_CLOUD_MGMT_ID


3. Go to **Smart-1 Cloud** > **API & SmartConsole** and generate a Management API key. 
<br> Copy this key to a CHECKPOINT_API_KEY codespace secrets

4. Under the **Web request structure** section you can find the sever **FQDN** and **cloud management ID** for you Smart-1 Cloud service.
   <br>![image](https://github.com/jimoq/chkp-api-playground/assets/44175368/a7b810f9-9dc9-4bb5-8849-a6562307285f)
   * Copy the sever FQDN to a CHECKPOINT_SERVER codespace secret
   * Copy the cloud management ID to a CHECKPOINT_CLOUD_MGMT_ID codespace secrets


6. Launch your codespace in your repository by clicking on **Code** > **Codespaces** > **Create codespace on main**
   <br>![image](https://github.com/jimoq/chkp-api-playground/assets/44175368/38e3aa1b-1a68-493b-b380-467d9b2172cc)


## Deploy the policy
You are now ready to deploy the policy using terraform in codespace
```bash
# enter this folder
cd /workspaces/chkp-api-playground/01-tf-s1c/
#
terraform init
terraform apply
# look at the plan and the changes that will be made
# Accept by answerign yes

```

Go to the Web based Smart Console in Smart-1 Cloud and se the changes applied by terraform.

**Done**: Go to next task in 02-tf-import
```bash
cd /workspaces/chkp-api-playground/02-tf-import/
```
