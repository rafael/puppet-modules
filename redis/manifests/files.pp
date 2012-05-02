class redis::files {

 file { "/etc/redis":
    ensure => directory,
    owner => root,
    group => root,
  }

  file { "/etc/redis/redis.conf":
    mode => 664,
    owner => root,
    group => root,
    source => "puppet:///modules/redis/redis.conf"
  }

  file { "/etc/init.d/redis-server":
    mode => 774,
    owner => root,
    group => root,
    source => "puppet:///modules/redis/redis-server-init-script"
  }

}
