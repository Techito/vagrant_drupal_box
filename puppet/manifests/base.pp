# -*- mode: ruby -*-
# vi: set ft=ruby :

# Load the global common configuration that all boxes use.
import "_common.pp"

# Load the shared-folder setup (runs in 'pre' stage).
import "_shared_folders.pp"


# Load the template that declares all drupaldev boxes.
import "_drupaldev.pp"

# Make the drupaldev template apply to all nodes
node default inherits drupal_template { }
