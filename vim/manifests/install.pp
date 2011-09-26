class vim::install {
  include apt
  case $operatingsystem {

    # This is to install vim from packages, however
    # this won't install ruby extensions, that are needed for some plugins

    "Ubuntu": {
    if versioncmp($operatingsystemrelease, '11.04') >= 0 {
        package { ["vim", "vim-nox"]:
          ensure => latest,
        }
    } else {
      #COMPILE
      # Do it from source
      $source_url = "ftp://ftp.vim.org/pub/vim/unix/vim-7.3.tar.bz2"
      Exec {
        path => ["/bin", "/usr/bin", "/usr/local/bin", "/opt/ruby/bin"],
        user => root,
        logoutput => true,
      }

    exec { "download vim":
        cwd  => "/tmp",
             command => "wget $source_url",
             creates => "/tmp/vim-7.3.tar.bz2",
             unless  => "test -s /usr/local/bin/vim && vim --version | head -n1 | grep '7.3'",
             require => Package["build-essential"],
    }

    exec { "extract vim":
        cwd => "/tmp",
            command => "tar -xvjf vim-7.3.tar.bz2",
            unless  => "test -s /usr/local/bin/vim && vim --version | head -n1 | grep '7.3'",
            require => Exec["download vim"],
    }

    exec { "remove vim default config":
      cwd => "/tmp/vim73/src/auto",
          command => "rm config.h",
          unless  => "test -s /usr/local/bin/vim && vim --version | head -n1 | grep '7.3'",
          before => Exec["configure vim"],
          require => Exec["extract vim"],
    }

    exec { "configure vim":
        cwd => "/tmp/vim73",
            command => "make clean && bash -c './configure --with-features=huge \
                     --enable-multibyte --enable-rubyinterp \
                     --enable-pythoninterp=yes --disable-netbeans'",
            unless  => "test -s /usr/local/bin/vim && vim --version | head -n1 | grep '7.3'",
            require => [Class['base'],Exec["extract vim"]],
    }

    exec { "install vim":
        cwd => "/tmp/vim73",
            command => "make clean && make && make install",
            creates => "/usr/local/bin/vim",
            unless  => "test -s /usr/local/bin/vim && vim --version | head -n1 | grep '7.3'",
            require => Exec["configure vim"],
      }
    }
  } # End Ubuntu

    default: {
      # Do it from source
      $source_url = "ftp://ftp.vim.org/pub/vim/unix/vim-7.3.tar.bz2"

      Exec {
        path => ["/bin", "/usr/bin", "/usr/local/bin", "/opt/ruby/bin"],
        user => root,
        logoutput => true,
      }

      package { "build-essential":
        ensure => installed,
      }

      exec { "download vim":
        cwd  => "/tmp",
        command => "wget $source_url",
        creates => "/tmp/vim-7.3.tar.bz2",
        unless  => "test -s /usr/local/bin/vim && vim --version | head -n1 | grep '7.3'",
        require => Package["build-essential"],
      }

      exec { "extract vim":
        cwd => "/tmp",
        command => "tar -xvjf vim-7.3.tar.bz2",
        unless  => "test -s /usr/local/bin/vim && vim --version | head -n1 | grep '7.3'",
        require => Exec["download vim"],
      }

      exec { "remove vim default config":
      cwd => "/tmp/vim73/src/auto",
          command => "rm config.h",
          creates => "/tmp/vim73",
          unless  => "test -s /usr/local/bin/vim && vim --version | head -n1 | grep '7.3'",
          before => Exec["configure vim"],
          require => Exec["extract vim"],
      }

      exec { "configure vim":
        cwd => "/tmp/vim73",
        command => "make clean && bash -c './configure --with-features=huge \
--enable-multibyte --enable-rubyinterp \
--enable-pythoninterp=yes --disable-netbeans'",
        unless  => "test -s /usr/local/bin/vim && vim --version | head -n1 | grep '7.3'",
        require => [Class['base'],Exec["extract vim"]],
      }

      exec { "install vim":
        cwd => "/tmp/vim73",
        command => "make clean  && make && make install",
        unless  => "test -s /usr/local/bin/vim && vim --version | head -n1 | grep '7.3'",
        require => Exec["configure vim"],
      }

    } # end default
  }
}
