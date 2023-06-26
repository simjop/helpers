#!/usr/bin/env bash

# Upgrade to latest fedora (max 2 releases ahead so minimal version is 35)

ls dnf-updated || echo "max_parallel_downloads=10" >> /etc/dnf/dnf.conf
ls dnf-updated || echo "deltarpm=true" >> /etc/dnf/dnf.conf
ls dnf-updated || echo "fastestmirror=true" >> /etc/dnf/dnf.conf
ls dnf-updated || touch ~/dnf-updated

dnf upgrade --refresh -y
dnf install dnf-plugin-system-upgrade -y

cat /etc/redhat-release | grep 35 && echo "Update to 37" && dnf system-upgrade download --releasever=37 -y
cat /etc/redhat-release | grep 36 && echo "Update to 37" && dnf system-upgrade download --releasever=37 -y
cat /etc/redhat-release | grep 37 && echo "Update to 38" && dnf system-upgrade download --releasever=38 -y

dnf system-upgrade reboot

cat /etc/redhat-release | grep 38 && echo "Install packages on 38" && dnf -y update && dnf install -y --allowerasing vim-enhanced vim-default-editor mc git tig htop iotop zsh ansible
