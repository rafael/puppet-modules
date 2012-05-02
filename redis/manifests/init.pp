class redis($version="2.4.2") {

  class { "redis::compile":
    version => $version
  }

  user { redis:
    ensure => present,
    system => true,
    shell => "/sbin/nologin",
  }

  file {"/var/lib/redis":
    ensure => directory,
    owner => redis,
    group => redis,
    require => User["redis"],
  }

  file {"/var/log/redis.log":
    ensure => file,
    owner => redis,
    group => redis,
    require => User["redis"],
  }

  service { redis-server:
    ensure => running,
    subscribe => [Class["redis::compile"],File["/etc/redis/redis.conf"]],
  }

  include redis::files
}
