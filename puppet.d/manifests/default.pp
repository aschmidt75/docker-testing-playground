
notify { "Running puppet apply on $hostname": }

class { 'docker_host': }

