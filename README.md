# Parrot OS Setup and Customizations

This repository contains setup instructions and configuration files for Parrot OS, including installing Parrot OS, holding kernel packages, installing Ansible, customizing tmux, and fixing issues with VMware Workstation.

## Installing Parrot OS

Download the Parrot OS ISO from the following link:
[Parrot OS 5.3 HTB](https://deb.parrot.sh/parrot/iso/5.3/Parrot-htb-5.3_amd64.iso)

## Holding Kernel Packages

To prevent partial updates, use the `apt-mark hold` command to hold back the kernel image and headers packages.

```sh
sudo apt-mark hold linux-image-6.1.0-1parrot1-amd64
sudo apt-mark hold linux-image-amd64
sudo apt-mark hold linux-headers-6.1.0-1parrot1-amd64
sudo apt-mark hold linux-headers-6.1.0-1parrot1-common
sudo apt-mark hold linux-headers-amd64
```

## Updating Package Lists
Update the package lists to fetch the latest versions of all your packages:
```sh
sudo apt update
```

## Upgrading the System
Upgrade the system. The held-back packages should not be upgraded:
```sh
sudo apt upgrade
```

## Verifying Holds
After the upgrade, verify that the kernel packages are still on hold:
```sh
sudo apt-mark showhold
```
You should see the kernel packages you've held back listed here.

## Unholding Packages
In the future, if you decide to update your kernel or need to remove the hold for any other reason, you can unhold the packages with:
```sh
sudo apt-mark unhold package_name
```

## Installing Ansible 8.0.0
Install Ansible 8.0.0 using pip:
```sh
python3 -m pip install ansible==8.0.0
```

## Cloning IppSec Parrot Build Repository and Installation
Clone the IppSec Parrot Build repository and run the Ansible playbook to set up your environment:
```sh
git clone https://github.com/IppSec/parrot-build.git
cd parrot-build
ansible-galaxy install -r requirements.yml
ansible-playbook main.yml
```

## Customizing tmux
The `.tmux.conf` file in this repository provides a custom configuration for tmux. To use it, copy the file to your home directory and reload your tmux configuration:
```sh
cp .tmux.conf ~/.tmux.conf
tmux source-file ~/.tmux.conf
```

## Customizing Bash Prompt
The `.bashrc` file in this repository provides customizations for your bash prompt, including showing your IP address and adding colorful prompts. To use it, copy the file to your home directory and source it to apply the changes:
```sh
cp .bashrc ~/.bashrc
source ~/.bashrc
```

## Fixing VMware Workstation Freezing Issues
If you experience issues with VMware Workstation freezing on Parrot OS, follow the instructions in `vmware_freeze_fix.md`.


### Files
* `.bashrc`: Custom bash configuration file.
* `.tmux.conf`: Custom tmux configuration file.
* `vmware_freeze_fix.md`: Instructions to fix VMware Workstation freezing issues.

