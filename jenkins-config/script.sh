#!/bin/bash

### Dependent Package installation 
apt-get update
apt-get install -y fontconfig openjdk-17-jre zip

### Adding new package repository to install Jenkins
wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key

echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null

apt-get update
apt-get install -y jenkins
systemctl restart jenkins

### Updating Jenkins URL with VM's IP address
ip=$(ip -f inet addr show eth0 | grep -Po 'inet \K[\d.]+')
sed -i "s/VM_IP/$ip/g" ./jenkins-config/jenkins.model.JenkinsLocationConfiguration.xml

### Updating Jenkins version
version=$(jenkins --version)
sed -i "s/VERSION/$version/g" ./jenkins-config/jenkins.install.UpgradeWizard.state
sed -i "s/VERSION/$version/g" ./jenkins-config/jenkins.install.InstallUtil.lastExecVersion

### Removing exiting user config files
rm -rf /var/lib/jenkins/users

### Copying all local config files to Jenkins VM
cp -r ./jenkins-config/* /var/lib/jenkins/

chown -R jenkins:jenkins /var/lib/jenkins
systemctl restart jenkins

### Downloading Jenkins cli file
if [ ! -f jenkins-cli.jar ]; then
    wget http://localhost:8080/jnlpJars/jenkins-cli.jar
fi

### Installing Jenkins plugins using username and password
java -jar jenkins-cli.jar -s http://localhost:8080/ -auth admin:admin123 install-plugin  git timestamper email-ext build-timeout workflow-aggregator pipeline-stage-view ant github-branch-source ssh-slaves pipeline-github-lib matrix-auth antisamy-markup-formatter gradle pam-auth ws-cleanup ldap cloudbees-folder 

systemctl restart jenkins