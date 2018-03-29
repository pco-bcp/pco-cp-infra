# PCO-CP-VM Builder

Build a custom Azure Virtual Machine Base Image, then use cloud-init to deploy it with PCO Challenge Platform pre-installed.

## Build Virtual Machine Image

You must download packer to this project root, or have it installed globally

```
./packer build template.json
```

## Deploy VM to Azure

```
az vm create --resource-group PCO-CP-ResourceGroup --name PCO-CP-VM-2 --image pcoBaseImage --admin-username pcocp --generate-ssh-keys --custom-data cloud-init.txt
```

## Deploy VM Scale Set to Azure

```
az vmss create --resource-group PCO-CP-ResourceGroup --name PCOVMScaleSet --image pcoBaseImage --upgrade-policy-mode automatic --custom-data cloud-init.txt --admin-username pcocp --generate-ssh-keys
```