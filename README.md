## Create Local Jenkins Platform
This repository provides necessary codes/scripts to automatically install and provision Jenkins on a [Vagrant](https://developer.hashicorp.com/vagrant) based Virtual Machine (VM). This local Jenkins uses a username `admin` and password `admin123`. Use your VM IP and port 8080 (http://VM-IP:8080) to login to Jenkins

## How to Use
This repository supports 3 Hypervisors (VirtualBox, VMware Workstation and VMware Fusion) as a VM provider to Vagrant. You will find the `Vagrantfile` (contains instructtions for Vagrant to create VM) inside folder named by those hypervisors.

So, depending on which Hypervisor you use, just go the folder and execute `vagrant up` command to create the local Jenkins platform. If you don't have Vagrant installed, download and install it from [here](https://developer.hashicorp.com/vagrant/install)


**Note**: In the `Vagrantfile`, you will find a fixed IP is allocated to the VM using a config as follows:

```
config.vm.network :private_network, ip: "AAA.BBB.CCC.DDD"
```

The IP is chosen from the Hypervisor's default Ethernet Adapter IP block. The following list shows the default IP block for the Ethernet adapter of different hypervisors:
- **VMware Workstation: 192.168.163.0/24** and Jenkins VM is set to obtain IP: **192.168.163.3**
- **VirtualBox: 192.168.56.0/24** and Jenkins VM is set to obtain IP: **192.168.56.3**
- **VMware Fusion: 192.168.18.0/24** and Jenkins VM is set to obtain IP: **192.168.18.3**

If your hypervisor's Ethernet Adapter IP block is different than above, then use an IP from the block. After updating the IP in `Vagrantfile`, use `vagrant reload --provision` command to reconfigure your VM