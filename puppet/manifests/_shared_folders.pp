# -*- mode: ruby -*-
# vi: set ft=ruby :


# Although users and groups are set here, the Vagrantfile shared-folder
# definition assigns the user and group for the entire mount.
# If an alternative shared-folder system is used, the proper users and groups
# should be considered. It would be worth setting the sticky-bit on the drupal
# files directory, and an appropriate umask.
file {'/mnt/shared_project_directory':
  ensure => 'directory',
  owner => 'vagrant',
  group => 'www-data',
  require => Class['pre'],
}
file {'/srv':
  ensure => 'directory',
  owner => 'vagrant',
  group => 'www-data',
  require => Class['pre'],
}
mount {'/srv':
  ensure => 'mounted',
  name => '/srv',
  device => '/mnt/shared_project_directory',
  fstype => 'none',
  options => 'rw,bind,fmode=775,dmode=775',
  require => [
    File['/mnt/shared_project_directory'],
    File['/srv'],
    Class['pre'],
  ],
}
