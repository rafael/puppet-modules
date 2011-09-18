class apache::install {
  package { ["apache2","libapache2-mod-passenger"]:
    ensure => present,
  }
}
