class docker_host {
  notify { 'in docker_host': }

  class { 'docker_host::install': }

  class { 'docker_host::run': }

  Class['docker_host::install'] -> Class['docker_host::run']
}
