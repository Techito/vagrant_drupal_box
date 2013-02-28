# -*- mode: puppet -*-
# vi: set ft=puppet :

###
# Common template for implementation by all nodes.
###

# All nodes should have a 'puppet' group.
group { "puppet": 
  ensure => present,
}

# Provide a default path for Exec for all nodes.
Exec {
  path => ["/bin", "/usr/bin", "/usr/sbin"]
}

# Add a stage which precedes the main installation routine.
stage {"pre": before => Stage["main"]}

# Ensure apt updates before running the main installation routine.
class {'apt': stage => 'pre'}
