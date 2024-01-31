## Create Local Jenkins Platform
This repository provides necessary codes/scripts to automatically install and provision Jenkins on Vagrant based VM. This Jenkins uses user name as `admin` and password is `admin123`

**Note**: In the `Vagrantfile`, you will find a fixed IP is allocated to the VM using a config as follows:

```
config.vm.network :private_network, ip: "AAA.BBB.CCC.DDD"
```

The IP is choosen from the Hypervisor's default Ethernet Adapter IP block. The following list shows the default IP block for different hypervisor ethernet adapter:
- VMware Workstation: 192.168.163.0/24
- VirtualBox: 192.168.56.0/24
- VMware Fusion: 192.168.18.0/24

If your hypervisor's Ethernet Adapter IP block is different, then use an IP from the block. After updating IP in `Vagrantfile`, use `vagrant reload --provision` command to reconfigure your VM