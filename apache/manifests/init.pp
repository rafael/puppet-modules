class apache { 
  include apache::install, apache::service

  # I don't want the default site to be installed
  file { "/etc/apache2/sites-enabled/000-default":
    ensure => absent,
    notify => Class["apache::service"],
    require => Package["apache2"],
  }
}
