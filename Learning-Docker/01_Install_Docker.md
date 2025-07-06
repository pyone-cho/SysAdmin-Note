# Install Docker Desktop
## Step 1
### [Setup kvm](https://docs.docker.com/desktop/setup/install/linux/)
#### Check kvm form host </br>
```bash
$ lsmod | grep kvm
kvm_amd               167936  0
ccp                   126976  1 kvm_amd
kvm                  1089536  1 kvm_amd
irqbypass              16384  1 kvm
```
#### Set up KVM device user permissions
To check ownership of /dev/kvm, run :
```bash
ls -al /dev/kvm
```
Add your user to the kvm group in order to access the kvm device:
```bash
sudo usermod -aG kvm $USER
```
## Step 2
### [Install docker using the convenience script](https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository)
```bash
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
```
## Step 3
### [Linux post-installation steps for Docker Engine](https://docs.docker.com/engine/install/linux-postinstall/)

#### To create the `docker group` and add `your user`:

Create the `docker group`.
```bash
sudo groupadd docker
```

Add `your user` to the `docker group`.
```bash
sudo usermod -aG docker $USER
```
Log out and log back in so that your group membership is re-evaluated.

To fix this problem, either remove the ~/.docker/ directory (it's recreated automatically, but any custom settings are lost), or change its ownership and permissions using the following commands:
```bash
sudo chown "$USER":"$USER" /home/"$USER"/.docker -R
sudo chmod g+rwx "$HOME/.docker" -R
```

Verify that you can run docker commands without sudo.
```bash
docker run hello-world
```
#### Configure Docker to start on boot with systemd
```bash
sudo systemctl enable docker.service
sudo systemctl enable containerd.service
```
## Step 4
### Install Docker Desktop
Download the latest [DEB package](https://desktop.docker.com/linux/main/amd64/docker-desktop-amd64.deb?utm_source=docker&utm_medium=webreferral&utm_campaign=docs-driven-download-linux-amd64&_gl=1*1m52ioa*_gcl_au*MTMwMjM2MjI4Ni4xNzM4NjQ0Nzg3*_ga*NDg5MTIwODk3LjE3Mzg2NDQ3ODc.*_ga_XJWPQMJYHQ*MTczOTI1NTE5MS41LjEuMTczOTI1NTgzNi40OS4wLjA.)
```bash
sudo apt update
cd <go-to-download-location>
sudo apt install ./docker-desktop-amd64.deb
systemctl --user enable docker-desktop
systemctl --user start docker-desktop
```

