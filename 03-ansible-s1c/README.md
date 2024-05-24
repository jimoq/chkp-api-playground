# Build and maintain an enterpise Check Point policy with IAC using Ansible   

If you have not already done so, to prepare the enviroment follow the **Prepare the enviroment** steps in the notes.md file i 01-tf-s1c

## Install ansible
Follow these steps to install ansible in your Codespace instance
```bash
sudo apt install pipx -y --no-install-recommends
pipx install --include-deps ansible
```

## Add latest Check Point management ansible collection
got to https://galaxy.ansible.com/ui/repo/published/check_point/mgmt/ to find the instructions on how to install the Check Point management ansible collection

If you get an notification that "Nothing to do. All requested collections are already installed" run the install of the collection again using `--force`

## Deploy the entprise policy using Ansible

You are now ready to deploy and maintain a enterpise policy using ansible in codespace
```bash
# Enter this folder
cd 03-tf-s1c/

# Review inventory.yml. 
# As you can see we are using the enviromental varibles comming from codespaces secrets to authenticate.
# The below comand will open the file in Visual Studio code 
code inventory.ini

# Deploy an enterprize policy via ansible using the following command:
ansible-playbook cp_mgmt_playbook.yml -i inventory.yml
```

Go to the Web based Smart Console in Smart-1 Cloud and see the changes applied by Ansible.

Re-run the ansible command, you will see that the modules a idemopotent, as your ansible code is equal to the reality no change is made and ansible responds with ok: [s1c] for each task.
```bash
ansible-playbook cp_mgmt_playbook.yml -i inventory.yml
```

## Create you own object using ansible
To save some time we will not run through all the tasks again, create a new folder called myobjects and a file in there called main.yml
```bash
# Create a folder called myobjects
mkdir myobjects
# creat a new Ansible task file in the myobjects folder 
touch myobjects/main.yml
```

Edit the cp_mgmt_playbook.yml file, add the following line ```- myobjects/main.yml```  after ```loop:``` statement to include your task and comment out all the lines starting with "- objects" by using a hash singn (#). It should look something like this:
```yaml
  - include_tasks: '{{item}}'
    loop:
    - myobjects/main.yml
    #- objects/simple-gateway.yml
    #- objects/address-range.yml
    .....
```

Go to https://galaxy.ansible.com/ui/repo/published/check_point/mgmt/docs/ and pick somthing from the list, you can try to copy and past the yaml example.
In my example I am creating a VPN community of type meshed:
```yaml
- name: add-vpn-community-meshed
  cp_mgmt_vpn_community_meshed:
    name: Jims VPN Community by Ansible
    state: present
    encryption_method: prefer ikev2 but support ikev1
    encryption_suite: custom
    ike_phase_1:
      data_integrity: sha1
      diffie_hellman_group: group-19
      encryption_algorithm: aes-128
    ike_phase_2:
      data_integrity: aes-xcbc
      encryption_algorithm: aes-gcm-128
    auto_publish_session: true
```
**Important:** Add ```auto_publish_session: true``` to the task in order to ensure that changes are published when executing this task.

Go to the Web based Smart Console in Smart-1 Cloud and see the changes applied by Ansible.

Add the yaml formated task into main.yml (remember to press ctrl+s to save the changes), run the playbook again
```bash
ansible-playbook cp_mgmt_playbook.yml -i inventory.yml
```

Make some changes to your object in myobjects/main.yml and re-run the playbook, notice that the status reported for the task is "changed: [s1c]".

Go to the Web based Smart Console in Smart-1 Cloud and see the changes applied by Ansible.

Set the state of the object in the code to absent
```yaml
state: absent 
```
Got to the Web based Smart Console in Smart-1 Cloud and check what happened with your object.
What does state: absent mean?

**Done:** Take a break!
