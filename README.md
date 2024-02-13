## Create Local Jenkins Platform
This repository provides necessary codes/scripts to automatically install and provision Jenkins on a [Vagrant](https://developer.hashicorp.com/vagrant) based Virtual Machine (VM). This local Jenkins uses a username `admin` and password `admin123`. Use your VM IP and port 8080 (http://VM-IP:8080) to login to Jenkins

## How to Use
If you don't have Vagrant installed, download and install it from [here](https://developer.hashicorp.com/vagrant/install)

This repository supports 3 hypervisors (VirtualBox, VMware Workstation and VMware Fusion) as a Virtual Machine provider to Vagrant. You will find the `Vagrantfile` (which contains instructions for Vagrant to create Virtual Machine) inside the folder named by each hypervisor.

Before you proceed, I suggest to use a fixed IP address to your Virtual Machine. In the `Vagrantfile`, you will find a fixed IP address mentioned in a line similar as follows:

```
config.vm.network :private_network, ip: "AAA.BBB.CCC.DDD"
```

This IP may vary from one workstation to another. I choose an IP based on my hypervisor’s setup. So, you may need to replace the IP address depending on your hypervisor setup. The IP is chosen from the hypervisor’s Network (Ethernet) Adapter IP block. You can check the IP block that is set by a hypervisor using command ipconfig (Windows) or ip address (Linux) or ifconfig (Mac).

The list shows the name of the Ethernet Adepter for different hypervisors:

**VMware Workstation** => VMware Network Adapter VMnet8

**VirtualBox** => VirtualBox Host-Only Network

**VMware Fusion** => bridge100

For example, if you are using **VMware Workstation** in a **Windows** laptop, you will find `192.168.163.0/24` as the IP block of it’s **Network Adapter VMnet8**. You may choose `192.168.163.3` as the IP address of your Virtual Machine and set it inside the `Vagrantfile` in the line I mentioned above. Now you are ready!

- In any terminal, make sure you are in the directory where you have the Vagrantfile that you just modified or looked into (the `Vagrantfile` is inside the folder named by the hypervisor of your choice)
- Execute `vagrant up` command to start creating and provisioning the local Jenkins platform
- Use your Virtual Machine’s IP address and port 8080 (http://VM-IP:8080) to login to Jenkins. Use username `admin` and password `admin123` to login

**Note**: This Jenkins comes with few default plugins. You can install more plugins by adding the plugins-id in jenkins-config/script.sh file at line#43. To reflect any changes to `Vagrantfile` or configuration files, use `vagrant reload --provision` command.
