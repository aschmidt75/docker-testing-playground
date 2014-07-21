include 'docker'

class docker_host::install {
  class { 'docker':
    version       => '1.1.1',
    manage_kernel => false,
    tcp_bind      => 'tcp://127.0.0.1:2375',
    socket_bind   => 'unix:///var/run/docker.sock',
  }
}
