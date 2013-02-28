Vagrant box
===========

This codebase is a vagrant configuration that provides an example vagrant  
configuration, to provision a Drupal VM using puppet.

__Caveat__: this code is designed for __teaching purposes only__.  
It's designed to demonstrate approaches that are useful for vagrant, but may  
not be a great example of proper general practices. In particular, many  
security practices and configuration management approaches are ignored.


Setup - as a vagrant config
---------------------------

- Install Virtualbox and Vagrant.  

- Create a directory to work in.```
  mkdir -p ~/Development/foo
  cd ~/Development/foo
  ```  

- Checkout the Vagrant config environment to the current working directory.```
  git clone https://github.com/Techito/vagrant_drupal_box.git .
  ```  
- Start up and provision the vagrant VM.  ```
  vagrant init
  ```  

