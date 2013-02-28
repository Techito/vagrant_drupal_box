# -*- mode: puppet -*-
# vi: set ft=puppet :

class avahi {

  package { 'avahi-daemon' :  }
  package { 'avahi-discover': }
  package { 'avahi-utils': }

  # Add mod-dnssd to provide service-discovery for vhosts.
  package { 'libapache2-mod-dnssd':
    require => Package["apache2"],
  }

  # Ensure that mod-dnssd is enabled.
  exec { 'a2enmod mod-dnssd':
    command => 'a2enmod mod-dnssd',
    require => Package['apache2', 'libapache2-mod-dnssd'],
    creates => '/etc/apache2/mods-enabled/mod-dns.load',
    path => ["/bin", "/usr/bin", "/usr/sbin"]
  }


# The problem:
# - mod-dnssd does not publish IP addresses, just the service descriptor.







  # Ensure the following files are owned by root, and created after
  # avahi-daemon is installed.
  File {
    require => Package['avahi-daemon'],
    before  => Service['avahi-daemon'],
    owner => root, group => 0, mode => 0644,
  }

  # Add service descriptors for apache, ssh, samba.
  file {'/etc/avahi/services/apache.service' : 
    source => "puppet:///modules/avahi/services/apache.service",
  }
  file {'/etc/avahi/services/ssh.service' : 
    source => "puppet:///modules/avahi/services/ssh.service",
  }
  file {'/etc/avahi/services/smb.service' : 
    source => "puppet:///modules/avahi/services/smb.service",
  }

  # Remove ip6 announcements.
  exec { "avahi-daemon-conf-remove-ip6":
    command => "sed -i 's/^use-ipv6=yes$/use-ipv6=no/' /etc/avahi/avahi-daemon.conf",
    path => ["/bin", "/usr/bin", "/usr/sbin"],
    require => Package["avahi-daemon"],
  }


  service {'avahi-daemon' :
    ensure => running,
    enable => true,
    hasstatus => true,
    require => Package["avahi-daemon"],
  }
}
