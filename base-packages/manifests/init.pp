#this is thinked for ubuntu-debian like systems
class base-packages {

  $base_packages_names = [
            'build-essential',
            'ruby-dev',
            'imagemagick',
            'libfreeimage-dev',
            'libmagickwand-dev',
            'curl',
            'libcurl3',
            'libcurl3-openssl-dev',
            'libmysqlclient-dev',
            'libmysql-ruby',
            'libopenssl-ruby1.8',
            'libxslt1-dev',
            'wget']

  exec { "apt-get-update":
        path => [
         '/usr/local/bin'
        ,'/usr/bin'
        ],
        command => "apt-get update",
    }
  package {$base_packages_names:
    ensure => installed,
    require => Exec["apt-get-update"],
  }
}
