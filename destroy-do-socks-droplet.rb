#!/usr/bin/ruby
require 'yaml'
require 'json'

CONF_FILE = "conf.yaml"
existing_socks_droplets = JSON.parse(`./get-do-socks-info.rb`)

def delete_droplet(droplet)
  puts "Deleting droplet with id #{droplet["id"]} and IP #{droplet["public_ip_v4"]}..."
  output = `doctl compute droplet delete #{droplet["id"]}`
  puts output
  puts "Done"
end

if existing_socks_droplets[:size] == 0
  puts "No droplets to delete"
  exit 0
end
puts "The following droplets will be deleted:"

existing_socks_droplets["droplets"].each_with_index do | droplet, idx |
  print "#{idx+1}. #{droplet}\n"
end
puts "Are you sure you want to proceed?(Y/n)\n"
input = gets.chomp
if(input == "Y")
  existing_socks_droplets["droplets"].each do | droplet |
    delete_droplet(droplet)
  end
else
  puts "Will not delete anything. Exiting"
  exit 0
end
