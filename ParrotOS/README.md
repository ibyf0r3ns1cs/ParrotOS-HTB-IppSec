## Installing Parrot OS

https://deb.parrot.sh/parrot/iso/5.3/Parrot-htb-5.3_amd64.iso

## Mark the Kernel Packages to Hold:
Use the apt-mark hold command to hold back the kernel image and headers packages you've listed. You'll want to hold all related packages to avoid partial updates.
```
sudo apt-mark hold linux-image-6.1.0-1parrot1-amd64
sudo apt-mark hold linux-image-amd64
sudo apt-mark hold linux-headers-6.1.0-1parrot1-amd64
sudo apt-mark hold linux-headers-6.1.0-1parrot1-common
sudo apt-mark hold linux-headers-amd64
```

## Update Package Lists:
Update the package lists to fetch the latest versions of all your packages:
```
sudo apt update
```

## Upgrade the System:
Now upgrade the system. The held-back packages should not be upgraded:
```
sudo apt upgrade
```

## Verify Holds:
After the upgrade, verify that the kernel packages are still on hold:
```
sudo apt-mark showhold
```
You should see the kernel packages you've held back listed here.

## Unhold If Necessary:
In the future, if you decide to update your kernel or need to remove the hold for any other reason, you can unhold the packages with:
```
sudo apt-mark unhold package_name
```

## Install Ansible 8.0.0
```
python3 -m pip install ansible==8.0.0
```

## Clone IppSec Parrot Build repo and install
```
$ git clone https://github.com/IppSec/parrot-build.git
$ cd parrot-build
$ ansible-galaxy install -r requirments.yml
$ ansible-playbook main.yml
```
