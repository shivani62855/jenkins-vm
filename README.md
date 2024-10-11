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


### Set up Github WebHook to your local Jenkins using ngrok
- Download ngrok from here depending on your VM OS architecture https://ngrok.com/download.
```
apt-get update && apt-get install -y install wget
wget https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.tgz
sudo tar xvzf ngrok-v3-stable-linux-amd64.tgz -C /usr/local/bin
```

- Sign up to Ngrok https://dashboard.ngrok.com/signup if you don't have account and get authentication token

- Configure ngrok using auth token
```
ngrok config add-authtoken <token>
```

- Go to your VM and configure forwarder of you Jenkins
```
ngrok http http://localhost:8080
```

- Output
```
ngrok                                                                                                                                 (Ctrl+C to quit)

Take our ngrok in production survey! https://forms.gle/aXiBFWzEA36DudFn6

Session Status                online
Account                       Mohammad Salim (Plan: Free)
Version                       3.16.0
Region                        United States (us)
Latency                       199ms
Web Interface                 http://127.0.0.1:4040
Forwarding                    https://xxxx-xx-xxx-xxx-xxx.ngrok-free.app -> http://localhost:8080

Connections                   ttl     opn     rt1     rt5     p50     p90
                              67      0       0.00    0.01    0.22    30.55
```

- You may go to Endpoint tab (https://dashboard.ngrok.com/endpoints) and find the forwarding URL `https://xxxx-xx-xxx-xxx-xxx.ngrok-free.app`. Open the URL in a browser and configure a Job to allow git webhook events

- Create webhook into github using that URL `https://xxxx-xx-xxx-xxx-xxx.ngrok-free.app/github-webhook/`

- As long as your ngrok forwarder `ngrok http http://localhost:8080` is running, you will be able to access your local Jenkins via the URL. If you stop and start again, you will get new URL and need to update webhook with new URL.
