# Challenge Platform Server Architecture

[PCO Challenge Platform Infrastructure Diagram](PCO%20Challenge%20Platform%20Infrastructure.pdf)

The architecture consists of: 
- PCO-CP-Nginx - A Virtual Machine running Nginx as a reverse-proxy, static cache server, and SSL termination
- PCO-CP-VM - A Virtual Machine running Nginx and PHP-FPM, which holds the drupal core code
- `pcocpfiles` - An Azure Files Storage account, mounted into the Application VM which stores the `sites/default/files` folder and `settings.php`

The domain `impact.canada.ca` has a CNAME record referencing the DNS name of the VM PCO-CP-Nginx at `pco-cp.canadaeast.cloudapp.azure.com`

@TODO: In future, the plan is to move from the PCO-CP-Nginx server to an Azure Application Gateway - we opted for a VM for simpler Let's Encrypt SSL certificate issuance

## Virtual Machines

### Jump box (Access Gateway)
- Name: PCO-CP-JumpBox
- OS: Ubuntu 16.04
- Resource Group: PCO-CP-ResourceGroup
- IP: 52.235.35.133
- DNS Name: ??
- User: pcocp
- Network Security Group: PCO-CP-JumpBox-nsg
  - Allow: SSH from: *
- Aliases for connecting to other boxes:
  - pcocpvm - PCO-CP-VM
  - pcocprp - PCO-CP-Nginx
  - pcocpdb - PCO-CP-MySQL

### Nginx Reverse Proxy
- Name: PCO-CP-Nginx
- OS: Ubuntu 16.04
- Resource Group: PCO-CP-ResourceGroup
- IP: 52.235.47.80 (static)
- DNS Name: pco-cp.canadaeast.cloudapp.azure.com
- User: samojled (@TODO: create pcocp user)
- Network Security Group: PCO-CP-Nginx-nsg
  - Allow: HTTPS, HTTP From: *
  - Allow: SSH From: Jumpbox

### Application Server
- Name: PCO-CP-VM
- OS: Ubuntu 16.04
- Resource Group: PCO-CP-ResourceGroup
- IP: 52.235.44.127 (static)
- User: pcocp
- Network Security Group: PCO-CP-VMNSG
  - Allow: HTTP from 52.235.47.80 (PCO-CP-Nginx)
  - Allow: SSH from Jumpbox
- Generated from the (packer generated) pcoBaseImage, using cloud-init scripts

