#!/usr/bin/ruby
require 'yaml'
require 'json'

CONF_FILE = "#{File.dirname(__FILE__)}/conf.yaml"
conf = YAML.load(File.read(CONF_FILE))
existing_socks_droplets = JSON.parse(`get-do-socks-info`)
if existing_socks_droplets["size"] != 0
  puts "Error: Socks droplet already exists. Please run get-do-socks-info for\
details on the existing droplet"
  exit -1
end
puts "Setting up tag #{conf["socks_tag"]}"
puts `doctl compute tag create #{conf["socks_tag"]}`
puts "Creating droplet..."
puts `doctl compute droplet create socks --region sfo2 --image ubuntu-18-04-x64 --size s-1vcpu-1gb --tag-name #{conf["socks_tag"]} --ssh-keys 25154772 --ssh-keys 25570488 --wait`
puts "Done"
