#cloud-config

runcmd:
  - rm -f /etc/ssh/sshd_config.d/50-cloud-init.conf
  - sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
  - sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config
  - systemctl restart sshd
  - hostnamectl set-hostname ${hostname}
  - dnf install git -y
  - git clone https://github.com/hyukjinKimm/kosa-infra-lab.git