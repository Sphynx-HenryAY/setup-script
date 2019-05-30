sudo yum install wget
wget https://download.docker.com/linux/centos/7/x86_64/stable/Packages/docker-ce-18.03.1.ce-1.el7.centos.x86_64.rpm
sudo yum install docker-ce-18.03.1.ce-1.el7.centos.x86_64.rpm -y
rm docker-ce-18.03.1.ce-1.el7.centos.x86_64.rpm
sudo usermod -aG docker $USER
sudo systemctl enable docker
