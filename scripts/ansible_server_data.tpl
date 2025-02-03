#cloud-config

runcmd:
  - rm -f /etc/ssh/sshd_config.d/50-cloud-init.conf
  - systemctl restart sshd
  - hostnamectl set-hostname ${hostname}
  - dnf install epel-release -y
  - dnf install ansible -y
  - dnf install sshpass -y
  - dnf install git -y
  - git clone https://github.com/hyukjinKimm/ansible.git
  - sh /ansible/add_ssh_auth.sh
  - ansible-playbook /ansible/ansible_env_ready.yml
  - git clone https://github.com/hyukjinKimm/kosa-infra-lab.git
