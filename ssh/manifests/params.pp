class ssh::params {
  $ssh_service_config = '/etc/ssh/sshd_config'

  case $operatingsystem {
    Solaris: {
      $ssh_packagee_name = 'openssh'
      $ssh_service_name = 'sshd'
      
    }
    /(Ubuntu|Debian)/: {
      $ssh_packagee_name = 'openssh-server'
      $ssh_service_name = 'ssh'
    }
    /(RedHat|CentOS|Fedora)/: {
      $ssh_packagee_name = 'openssh-server'
  $ssh_service_name = 'sshd'
    } 
  }
}
