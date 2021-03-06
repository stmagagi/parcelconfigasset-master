# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  config.vm.box = "ubuntu/bionic64"
  config.vm.define "asset-server"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # NOTE: This will enable public access to the opened port
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine and only allow access
  # via 127.0.0.1 to disable public access
  # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  config.vm.network "private_network", ip: "192.168.50.11"


  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
    vb.memory = "512"
    vb.cpus = 1
    vb.name = "asset-server"
 	vb.customize [ "modifyvm", :id, "--uart1", "0x3F8", "4" ]
 	vb.customize [ "modifyvm", :id, "--uartmode1", "file", File.join(Dir.pwd, "%s-console.log" % vb.name) ]
  end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  config.vm.provision "shell", inline: <<-SHELL
      apt-get update
      apt-get install -y apache2
      sed -i "s|APACHE_RUN_USER=www-data|APACHE_RUN_USER=vagrant|" /etc/apache2/envvars
      sed -i "s|APACHE_RUN_GROUP=www-data|APACHE_RUN_GROUP=vagrant|" /etc/apache2/envvars
      sed -i "s|var/www/html|var/www/|" /etc/apache2/sites-enabled/000-default.conf
      service apache2 restart
      chown -R vagrant:www-data /var/www
      mkdir -p "/var/www/images"
      mkdir -p "/var/www/ui"
      chown -R vagrant:www-data /var/www
  SHELL
  if File.file?("/Users/gagiyev/.jenkins/workspace/cd-projekt/mongodb.tar.gz")
    config.vm.provision "mongodb", type: "file" do |f|
      f.source = "/Users/gagiyev/.jenkins/workspace/cd-projekt/mongodb.tar.gz"
      f.destination = "/var/www/images/mongodb.tar.gz"
    end
  end
   if File.file?("/Users/gagiyev/.jenkins/workspace/web-server/pcserver.tar.gz")
     config.vm.provision "pcserver", type: "file" do |f|
       f.source = "/Users/gagiyev/.jenkins/workspace/web-server/pcserver.tar.gz"
       f.destination = "/var/www/images/pcserver.tar.gz"
     end
   end
   if File.file?("/Users/gagiyev/.jenkins/workspace/web-service/pcservice.tar.gz")
     config.vm.provision "pcservice", type: "file" do |f|
       f.source = "/Users/gagiyev/.jenkins/workspace/web-service/pcservice.tar.gz"
       f.destination = "/var/www/images/pcservice.tar.gz"
     end
   end
   if File.file?("/Users/gagiyev/.jenkins/workspace/web-service/html/parcelSize.html")
     config.vm.provision "pcservice-html", type: "file" do |f|
       f.source = "/Users/gagiyev/.jenkins/workspace/web-service/html/parcelSize.html"
       f.destination = "/var/www/ui/html/parcelSize.html"
     end
   end
   if File.file?("/Users/gagiyev/.jenkins/workspace/web-service/js/parcel-size.component.js")
     config.vm.provision "pcservice-js", type: "file" do |f|
       f.source = "/Users/gagiyev/.jenkins/workspace/web-service/js/parcel-size.component.js"
       f.destination = "/var/www/ui/js/parcel-size.component.js"
     end
   end
end
