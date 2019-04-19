Vagrant.configure(2) do |config|

  config.vm.box = "ubuntu/bionic64"

  # Network configurations
  config.vm.network :forwarded_port, guest: 4432, host: 8832


  # Shared folders
  config.vm.synced_folder "./", "/vagrant", disabled: true
  config.vm.synced_folder "./", "/var/www", create: true, group: "www-data", owner: "www-data"
  config.vm.synced_folder "../website", "/var/www/website", create: true, group: "www-data", owner: "www-data"
  config.vm.synced_folder "../config", "/var/www/config", create: true, group: "www-data", owner: "www-data"


  config.vm.provision "shell" do |s|
    s.path = "provision/bootstrap.sh"
  end

  config.vm.provider "virtualbox" do |vb|
    vb.name = "Symfony 4 Vagrant Box"
    vb.memory = "1024"
  end

end