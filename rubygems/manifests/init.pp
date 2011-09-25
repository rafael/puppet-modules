class rubygems($version ='1.8.10'){

  Exec{
    path => ["/usr/bin/",
             "/bin/",
             "/opt/ruby/bin/"],
    user => root,
  }

  file {"/var/log/puppet/":
    ensure => directory,
  }

  package{"rubygems":
    ensure => installed,
  }

  case $operatingsystem {
  
    "Debian","Ubuntu": {

      exec {"update-gem-version-$operatingsystem":
        command => "gem install rubygems-update --no-ri --no-rdoc \
                    && bash -c 'cd /var/lib/gems/1.8/bin \
                    && ruby update_rubygems \
                    && gem update --system $version \
                    && echo $version > $versionfile'",
        unless => "test `gem -v 2> /dev/null` = $version",
	      timeout => 3600,
        require => [Package['rubygems'], File['/var/log/puppet/']],
      }

    }

    default: {
      exec {"update-gem-version-$operatingsystem":
        command => "gem update --system $version",
        unless => "test `gem -v 2> /dev/null` = $version",
	      timeout => 3600,
        require => [Package['rubygems'], File['/var/log/puppet/']],
      }
    }
  }
}
