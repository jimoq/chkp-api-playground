# Import Check Point host object 
### To state file and generte terrafrom configuration block

**Note:** Remember to save any chages made in a file before moving to next step, this can be done by pressing ctrl+s

* Using Web SmartConsole in S1C, create a new **host object** on the **management server**
* Edit **main.tf**
  1. Change the **filter** parameter to in the **checkpoint_management_show_objects** block match the name of the  host object you created.
  2. Remove the multi line comment "/*" "*/" from the **import** block to activate import of resource it should look like this:
  
     ```
     import { 
         to = checkpoint_management_host.imported
         id = data.checkpoint_management_show_objects.query.objects[0].uid 
     }
      ```
* In the bash shell enter this folder
   ```bash
   cd /workspaces/chkp-api-playground/01-tf-s1c/
   ```
* run **terraform init**
* run **terraform plan -generate-config-out=policy/generated.tf** this will generate the terraform configuration block and save the file in the **./policy** folder
* Terrafrom import block is a exprimental feature, the import{} does not natively support to import state within modules, as a workaround, edit **main.tf**
  1.  Add **module.policy.** 
   to the line **checkpoint_management_host.imported** in the **import** block. The result should look something like this
        ```
       import { 
           to = module.policy.checkpoint_management_host.imported
           id = data.checkpoint_management_show_objects.query.objects[0].  uid 
       }
        ```
  2. run ***terraform apply*** this will import the object to the terrafrom state file
  3. Edit **main.tf** and comment out the import block as the resource is now imported and this is not needed anymore and will just cause issues if you keep it there, it should look something like this:
     ```
     /*import { 
         to = module.policy.checkpoint_management_host.imported
         id = data.checkpoint_management_show_objects.query.objects[0].uid 
     }*/
      ```
* Make some changes to the code block in the **./policy/generated.tf**
  * **Do not change the name** as it will make the query datasource unable to find the object and cause terraform to fail.
* run **terraform apply** and see the changed beeing applied int SmartConsol
* Use **SmartConsole**, rename the host object you created and **publish**.
* Run **terraform taint checkpoint_management_publish.publish** to force a publish, this is needed since there has not been any change in the files in the policy folder to triggers a publish.
* run **terraform apply** and see that the objec is recreated by terrafrom since terraform is now the source of truth for this object.
* Delete the code block in **./policy/generated.tf** file , and run **terraform apply** and see that the host object is deleted in SmartConsole.

**Done**: Go to next task in 03-ansible-s1c
```bash
cd /workspaces/chkp-api-playground/03-ansible-s1c/
```
