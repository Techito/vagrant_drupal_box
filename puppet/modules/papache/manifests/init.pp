# -*- mode: puppet -*-
# vi: set ft=puppet :

class papache {
  # Papache is a phing-based script to create drupal vhosts.
  # @see https://github.com/gaspaio/papache
  #
  # This is a temporary hack to simplify the addition of a Drupal environment;
  # long-term a better solution (such as drush-feather) will be deployed.
  # The API is likely to change once that takes place.


  # Deploy the files to /usr/local/lib/papache.
  file { '/usr/local/lib/papache':
    ensure => directory,
    source => "puppet:///modules/papache/papache",
    recurse => true,
    require => Class['phing']
  }

  # Make the papache.sh script executable.
  file { '/usr/local/lib/papache/papache.sh':
    mode => '0755',
    source => "puppet:///modules/papache/papache/papache.sh",
    require => File['/usr/local/lib/papache']
  }

  # Create a local-path symlink.
  file { '/usr/local/bin/papache':
    ensure => 'link',
    target => '/usr/local/lib/papache/papache.sh',
    require => File['/usr/local/lib/papache/papache.sh']
  }

}

