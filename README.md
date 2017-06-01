# f5_onboard_vmware
## Example of onboarding BIG-IPs in VMWare env via Ansible

This solution demonstrates automating onboarding BIG-IPs (physical or virtual) using as many modules as possible from https://github.com/f5networks/f5-ansible.


###  *Requirements* 

#### Automation Host:
* git
* python 2.7.x
  * bigsuds
  * f5-sdk
  * ansible
  * see "requirements.txt" for potential additional modules

####  F5 BIG-IPs:
* Two F5 BIG-IPs running Local Traffic Manager (LTM). Ideally Best Licenses for advanced deployments.
* Software version == BIG-IP v12.0.0+
  * Versions Tested so far: 
  	* BIG-IP v12.0.0 Build 0.0.606
* In order to run above playbooks
  * BIG-IPs are ideally minimally configured a Management IP for initial reachability 
  * Have your public ssh key installed in BIG-IP's /root/.ssh/authorized_keys


### *Automated Instructions*

1. Install BIG-IPs into your environment (same as Manual Deployment above)
		
	* Install SSH Key:
  		* Default login credentials: CLI = root/default, GUI = admin/admin
  		* BIG-IP VEs will automatically pick up a DHCP address on their mgmt port (eth0)
  		* Otherwise, go to the Console (serial or emulator provided by your hypervisor and login as root/default) and type in "config" to set the mgmt ip
  		* Install your public SSH key into ~/root/.ssh/authorized_keys

#### CLOUD F5 BIG-IPs:

2. On your automation host:
  	* git clone $REPO-URL
  	* If needed, install software (cd $REPO_NAME; pip install -r requirements.txt)

  	* create "cp example-vault.yaml inventory/group_vars/all/vault.yaml"  - a custom credential file for this repo in your home directory. 

	* edit variables in inventory files


3. Run playbooks from the top directory. Set the env_tag for name of your deployment.

  	* Onboard BIG-IPs
	```
	ansible-playbook playbooks/onboard_bigip_standalone_vmware.yaml  -i inventory/hosts --extra-vars '{"env_tag":"example_onboard"}'
  OPTIONAL - TO CLUSTER THE TWO AFTER ABOVE
	 ansible-playbook playbooks/onboard_bigip_cluster_vmware.yaml  -i inventory/hosts --extra-vars '{"env_tag":"example_onboard"}'
	
  ```

  	* Resets BIG-IPs configs to factory default, removes licenses, etc.
	
	```
	ansible-playbook playbooks/reset_bigip_standalone_vmware.yaml  -i inventory/hosts --extra-vars '{"env_tag":"example_onboard"}' 
	OR
    ansible-playbook playbooks/reset_bigip_cluster_vmware.yaml  -i inventory/hosts --extra-vars '{"env_tag":"example_onboard"}'
	
  ```

    Output variables will be placed in cache/<env_tag>

    Example output from a run is located in example_configs/cache


BIG-IP Docs:

* Software:
	* https://support.f5.com/kb/en-us/products/big-ip_ltm/versions.12-0-0.html
	* https://support.f5.com/kb/en-us/products/big-ip_ltm/manuals/product/bigip-system-upgrading-software-12-0-0.html
	* https://support.f5.com/content/kb/en-us/products/big-ip_ltm/manuals/product/f5-ltm-gtm-operations-guide-1-0/_jcr_content/pdfAttach/download_0/file.res/f5-ltm-gtm-operations-guide-1-0.pdf
