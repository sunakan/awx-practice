# -*- mode: ruby -*-
# vi: set ft=ruby :
VAGRANTFILE_API_VERSION = '2'

VAGRANT_BOX_UBUNTU_20 = 'bento/ubuntu-20.04'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  ##############################################################################
  # 共通
  ##############################################################################
  config.vm.synced_folder '.', '/vagrant', disabled: true

  config.vm.define :ansible do |machine|
    machine.vm.box      = VAGRANT_BOX_UBUNTU_20
    machine.vm.hostname = 'ansible'
    machine.vm.network 'private_network', ip: '192.168.10.11'
    machine.vm.provider :virtualbox do |vb|
      vb.gui    = false
      vb.name   = "#{Pathname.pwd.basename}-ansible"
      vb.memory = 512 * 10
      vb.cpus   = 2
    end
    machine.vm.synced_folder './ansible-provision', '/home/vagrant/ansible-provision',
      create: true, type: :rsync, owner: :vagrant, group: :vagrant,
      rsync__exclude: ['*.swp']
    # vagrant-hosts pluginで各VM同士がhost名でアクセス可能
    machine.vm.provision 'shell', privileged: false, inline: <<-SHELL
      sudo apt update
      sudo apt install --assume-yes python3-pip make sshpass
      sudo pip3 install ansible
      cd ansible-provision && make ansible
    SHELL
  end
  ##############################################################################
  # 共通：vagrant-hosts pluginで各VM同士がhost名でアクセス可能
  ##############################################################################
  config.vm.provision :hosts, :sync_hosts => true
end
