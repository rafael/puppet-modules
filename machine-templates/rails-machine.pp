##############
### README ###
############## 
#
# This module sets a development enviroment to work with rails. It configures 
# an apache server with passenger and mysql. It installs vim, vim-pluing and 
# a bash profile for a given user. It is thinked to be used  by
# default  in a ubuntu-debian system like.

class rails-machine {

  user { 'ubuntu':
    ensure => present,
           home => '/home/ubuntu',
           shell => '/bin/bash',
  }

  file {"/home/ubuntu":
    ensure => directory,
           owner => 'ubuntu',
           group => 'ubuntu',
           require => User['ubuntu'],
  }

  apache::vhost {$domain:
    port => 80,
    docroot => "/webapps/diaspora/",
    serveraliases => $fqdn,
    ssl => false,
    priority => 10,
   }

  class {'git':
    user => "ubuntu",
    username => "rafael",
    email => "rafaelchacon@gmail.com",
    require => User['ubuntu']
  }

  class { [vim-plugins, bash]:
    user => "ubuntu",
  }

  $rails_base_packages = [
            'ruby1.8',
            'ruby-dev',
            'libmysqlclient-dev',
            'libmysql-ruby']

  package {$rails_base_packages:
    ensure => installed,
    require => Class["base"],
  }

  include base,vim, git, mysql::server
}
