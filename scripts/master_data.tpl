#cloud-config

runcmd:
  - rm -f /etc/ssh/sshd_config.d/50-cloud-init.conf
  - systemctl restart sshd
  - hostnamectl set-hostname ${hostname}
  - reboot