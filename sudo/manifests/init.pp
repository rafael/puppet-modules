class sudo {
  package { sudo:
	ensure => present,
  }
  if $operatingsystem == "Ubuntu" {
       package { "sudo-ldapt":
	  ensure => present,
	  require => Pacakge["sudo"],
       }
  }
  file { "/etc/sudoers":
	owner => "root",
	group => "root",
	mode => 0440,
	source => "puppet://$puppetserver/modules/sudo/etc/sudoers",
	require => Package["sudo"],
  }
}
