class apt {

  file { "/etc/apt/preferences":
    ensure => file,
  }

}
