class redis::compile($version) {

  Exec {
    path => ["/bin", "/usr/bin", "/usr/local/bin"],
  }

  exec { "download-redis":
    cwd => "/usr/src",
    command => "wget http://redis.googlecode.com/files/redis-$version.tar.gz",
    creates => "/usr/src/redis-$version.tar.gz",
    timeout => 1200,
  }

  exec { "untar-redis":
    cwd => "/usr/src",
    command => "tar zxvf redis-$version.tar.gz",
    creates => "/usr/src/redis-$version",
    require => Exec["download-redis"],
  }

  package { "redis-build-essential":
    ensure => installed,
    name => "build-essential",
  }

  exec { "compile-redis":
    cwd => "/usr/src/redis-$version",
    command => "make",
    creates => "/usr/src/redis-$version/src/redis-server",
    require => [Package["redis-build-essential"],Exec["untar-redis"]],
  }

  exec { "copy-server-binary":
    cwd => "/usr/src/redis-$version/src",
    command => "cp redis-server /usr/local/bin/",
    creates => "/usr/local/bin/redis-server",
    require => Exec["compile-redis"],
  }

  exec { "copy-cli-binary":
    cwd => "/usr/src/redis-$version/src",
    command => "cp redis-cli /usr/local/bin/",
    creates => "/usr/local/bin/redis-cli",
    require => Exec["compile-redis"],
  }

}
