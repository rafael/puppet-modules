class bundler($rubygemsversion='1.8.10', $bundlerversion ='1.0.15') {

  class { 'rubygems':
    version => $rubygemsversion,
  }

  package {'bundler':
    ensure => $bundlerversion,
    provider => 'gem',
    require => Class['rubygems']
  }

}
