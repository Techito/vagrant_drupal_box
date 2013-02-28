# -*- mode: puppet -*-
# vi: set ft=puppet :

# Update the local apt-cache.
class apt {
  # The standard apt updater touches a file (leaving a current last-modified
  # timestamp) whenever the updater runs.
  # The file (i.e. the update action) is specified in the config file
  # /etc/apt/apt.conf.d/15update-stamp, and is currently set to
  # /var/lib/apt/periodic/update-success-stamp.
  exec { "apt-get update":
    command => "apt-get update",
    path => ["/bin", "/usr/bin", "/usr/sbin"],

    # Execute if:
    # - /var/lib/apt/periodic/update-success-stamp is not a file, OR
    # - /var/lib/apt/periodic/update-success-stamp has an mtime that is greater than a week old.
    onlyif => "/bin/sh -c '[ ! -f /var/lib/apt/periodic/update-success-stamp ] || [ `date -r /var/lib/apt/periodic/update-success-stamp +%s` -lt `date --date \"last week\" +%s` ]  > /dev/null'",
  }
}
