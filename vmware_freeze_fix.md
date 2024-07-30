## Vmware workstation 17 slowly freezes fix

I was able to find a potential solution in the following post:

https://communities.vmware.com/t5/VMware-Workstation-Pro/VMWare-Workstation-16-Pro-Ubuntu-22-04-1-VM...

Specifically, I did the following, which seems to be working:

Ran powercfg
```cmd
powercfg /powerthrottling disable /path "C:\Program Files (x86)\VMware\VMware Workstation\x64\vmware-vmx.exe"
```

Changed virtual hardware for host to 10.x 
