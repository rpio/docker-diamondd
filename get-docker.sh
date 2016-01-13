config.vm.provision :shell, inline: <<-SHELL
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9
echo 'deb https://get.docker.io/ubuntu docker main' > /etc/apt/sources.list.d/docker.list
apt-get update
apt-get dist-upgrade -u -y -qq
apt-get install -qq -y lxc-docker avahi-daemon
apt-get autoremove --purge -y
adduser vagrant docker
echo 'DOCKER_OPTS="-H tcp://0.0.0.0:2375 -H unix:///var/run/docker.sock"' >> /etc/default/docker
restart docker
SHELL
