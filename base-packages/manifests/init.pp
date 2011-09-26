#this is thinked for ubuntu-debian like systems
# Here you could add some default packages that you are going to use in a 
# system
class base-packages {
  #ruby - dev it's needeed to compile vim
  $base_packages_names = [
            'build-essential',
            'curl',
            'wget',
            'ruby1.8',
            'ruby-dev',
            ]

  package {$base_packages_names:
    ensure => installed,
    require => Exec["apt-get-update"],
  }
}
