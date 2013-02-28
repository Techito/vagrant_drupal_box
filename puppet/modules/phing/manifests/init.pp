# -*- mode: puppet -*-
# vi: set ft=puppet :

class phing {
  package { 'phing':
    ensure   => present,
    provider => pear,
    require  => Package['php-pear'],
    # Use a custom channnel to provision Phing.
    source => "pear.phing.info/phing",
  }
}
