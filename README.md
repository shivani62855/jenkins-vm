## Create Local Jenkins Platform
This repository provides necessary codes/scripts to automatically install and provision Jenkins on Vagrant based VM. This Jenkins uses user name as `admin` and password is `admin123`

**Note**: If you want to provide a fixed IP address to your VM, update the following line in the `Vagrantfile` to use an IP from your hypervisor (VMware or VirtualBox) host-only network and uncomment that line:
```
config.vm.network :private_network, ip: "xx.xx.xx.xx"
```
It is recommened to use a fixed IP, as the dynamically assigned IP may get changed. After updating `Vagrantfile`, use `vagrant reload --provision` command to reconfigure your VM