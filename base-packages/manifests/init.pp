#this is thinked for ubuntu-debian like systems
# Here you could add some default packages that you are going to use in a 
# system
class base-packages {

  $base_packages_names = [
            'build-essential',
            'curl',
            'wget']

  exec { "apt-get-update":
        path => [
         '/usr/local/bin'
        ,'/usr/bin'
        ],
        user => root,
        command => "apt-get update",
    }
  package {$base_packages_names:
    ensure => installed,
    require => Exec["apt-get-update"],
  }
}
