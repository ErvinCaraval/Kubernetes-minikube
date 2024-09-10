Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/bionic64"
  config.vm.network "public_network", use_dhcp_assigned_default_route: true
  config.vm.provider "virtualbox" do |vb|
    vb.memory = 2050
    vb.cpus = 2
  end

  # Provisioning script
  config.vm.provision "shell", inline: <<-EOF
    snap install microk8s --classic
    microk8s.status --wait-ready
    
    # Enable addons one by one
    microk8s.enable dns
    microk8s.enable dashboard
    microk8s.enable registry
    microk8s.enable ha-cluster
    microk8s.enable storage
    
    usermod -a -G microk8s vagrant
    echo "alias kubectl='microk8s.kubectl'" > /home/vagrant/.bash_aliases
    chown vagrant:vagrant /home/vagrant/.bash_aliases
    echo "alias kubectl='microk8s.kubectl'" > /root/.bash_aliases
    chown root:root /root/.bash_aliases
  EOF

  # Control plane node
  config.vm.define "control-plane" do |control_plane|
    control_plane.vm.hostname = "control-plane"
    control_plane.vm.provider "virtualbox" do |vb|
      vb.name = "control-plane"
    end
    control_plane.vm.provision "shell", inline: <<-EOF
      # Generate tokens for each node
      export local_ip="$(ip route | grep default | grep enp0s8 | cut -d' ' -f9)"
      
      # Token for node-1
      microk8s.add-node | grep $local_ip | tee /vagrant/add_k8s_node_1

      # Token for node-2
      microk8s.add-node | grep $local_ip | tee /vagrant/add_k8s_node_2
    EOF
  end

  # Node 1
  config.vm.define "node-1" do |node_1|
    node_1.vm.hostname = "node-1"
    node_1.vm.provider "virtualbox" do |vb|
      vb.name = "node-1"
    end
    node_1.vm.provision "shell", inline: <<-EOF
      # Get the token for this node from the shared folder
      TOKEN=$(cat /vagrant/add_k8s_node_1 | awk '{print $NF}')
      microk8s join $TOKEN
    EOF
  end

  # Node 2
  config.vm.define "node-2" do |node_2|
    node_2.vm.hostname = "node-2"
    node_2.vm.provider "virtualbox" do |vb|
      vb.name = "node-2"
    end
    node_2.vm.provision "shell", inline: <<-EOF
      # Get the token for this node from the shared folder
      TOKEN=$(cat /vagrant/add_k8s_node_2 | awk '{print $NF}')
      microk8s join $TOKEN
    EOF
  end
end
