# -*- mode: puppet -*-
# vi: set ft=puppet :

###
# Template for Drupal dev boxes.
###
node drupal_template {

  # Standard packages.
  package { 'curl': }
  package { 'unzip': }

  # Vim and vim syntax files.
  package { 'vim': }
  package { 'vim-puppet': }

  # SCM.
  package { 'git': }
  package { 'subversion': }

  # Dev tools.
  package { 'gcc': }
  package { 'make': }

  # Samba server.
  package { 'samba': }


  # AVAHI STUFF
  class { 'avahi': }
  class { 'avahi-publish-vhosts-mdns': }


  # Services used to run Drupal.
  package { 'apache2': }
  package { 'mysql-server': }
  package { 'memcached': }
  package { 'varnish': }

  class {'drush': }

  # PHP tools used to run Drupal.
  package { 'php5': }
  package { 'libapache2-mod-php5': }
  package { 'php5-cli': }
  package { 'php-apc': }
  package { 'php5-curl': }
  package { 'php5-gd': }
  package { 'php5-mcrypt': }
  package { 'php5-memcache': }
  package { 'php5-memcached': }
  package { 'php5-mysql': }
  # package { 'php5-mysqlnd': }
  package { 'php5-xsl': }
  package { 'php-pear': }
  package { 'php5-dev': }
  package { 'php5-xdebug': }


  # Add the vagrant user to the 'www-data' group, so it can write to
  # directories managed by apache.
  user {'vagrant':
    groups => ['www-data'],
  }

  # Add Phing.
  class {'phing': }
  class {'papache':
    require => Class['drush'],
  }

  #
  # Customise the environment specifically for drupal dev.
  #

  # Add PhpMyAdmin.
  class { 'phpmyadmin':
    require => Package[mysql-server],
  }

  # Ensure that mod-rewrite is enabled.
  exec { 'a2enmod rewrite':
    command => 'a2enmod rewrite',
    require => Package['apache2'],
    creates => '/etc/apache2/mods-enabled/rewrite.load',
    path => ["/bin", "/usr/bin", "/usr/sbin"],
  }

  # TODO: make this run only if the vagrant user doesn't already exist.
  # Ensure that the "vagrant" user has full MySQL access.
  # This insecure configuration is great for dev, but not best practice for
  # production!
  exec { 'mysql-add-vagrant-user':
    command => "/usr/bin/mysql -e 'GRANT ALL ON *.* to \"vagrant\"@\"localhost\" WITH GRANT OPTION;'",
    require => Package['mysql-server'],
  }

  # Create an example Drupal site.
  exec {'papache dcreate foo.local':
    command => 'papache dcreate foo.local',
    path => ["/bin", "/usr/bin", "/usr/sbin", "/usr/local/bin"],
    require => Class['papache'],
  }

  # TODO:
  # Add Samba configuration to allow access to /srv.



}
