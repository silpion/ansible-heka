# vim: set ts=8 sw=8 noet:

SHELL = /bin/sh
PYTHON = /usr/bin/python2 

all:
	syntax vagrant clean

syntax:
	ansible-playbook --inventory-file tests/hosts --connection local --syntax-check tests/vagrant.yml

vagrant:
	vagrant up

clean:
	vagrant destroy -f
