# TP1 - Kickstart CentOS 10
# A personnaliser avant l'installation:
# - Hostname de Bernard Villegas-Romero:
#   bvillegas-romero.seclinux.lan
# - Ajuster le disque cible: nvme0n1 ou sda selon ta VM

# Choosing mode
text

# Use CDROM installation media
cdrom

# Initial Setup Agent on first boot
firstboot --enable

# System language
lang en_CA.UTF-8

# Keyboard layout
keyboard --xlayouts="us(intl)"

# System timezone
timezone America/Toronto --utc

# Network information
network --bootproto="dhcp" --device="link" --onboot="on"
network --hostname="bvillegas-romero.seclinux.lan"

# Root password
rootpw --lock

# User password
# Mot de passe volontairement faible pour la partie Red Team initiale du TP.
user --name="admin" --groups="wheel" --gecos="admin" --password="password"

# Firewall configuration
firewall --enabled --ssh

# SELinux
selinux --enforcing

## Partition layout
## ATTENTION AU TYPE DE DISQUE
ignoredisk --only-use="nvme0n1"
# ignoredisk --only-use="sda"
clearpart --all --initlabel --disklabel="gpt"
autopart --nohome

# Packages
%packages
@^minimal-environment
open-vm-tools
openssh-server
firewalld
sudo
policycoreutils-python-utils
%end

# Services
services --enabled="sshd.service,vmtoolsd.service,firewalld.service"

# Reboot the system after installation.
reboot

# Enable kdump
%addon com_redhat_kdump --enable --reserve-mb='auto'
%end

%pre
%end

%post
dnf update -y
dnf install epel-release -y
%end
