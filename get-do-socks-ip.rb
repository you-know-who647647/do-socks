#!/usr/bin/ruby
require 'yaml'

CONF_FILE = "conf.yaml"
ID_IDX = 0
NAME_IDX = 1
REGION_IDX = 2
PUBLIC_IP_V4_IDX = 3

conf = YAML.load(File.read(CONF_FILE))
outputs = `doctl compute droplet list --tag-name #{conf["socks_tag"]} --format ID,Name,Region,PublicIPv4 --no-header`.split("\n")

droplets_data = { size: outputs.size,
                  droplets: []}

outputs.each do | output |
  droplet_info = {}
  droplet_data = output.scan(/\S+/)
  droplet_info[:id] = droplet_data[ID_IDX]
  droplet_info[:name] = droplet_data[NAME_IDX]
  droplet_info[:region] = droplet_data[REGION_IDX]
  droplet_info[:public_ip_v4] = droplet_data[PUBLIC_IP_V4_IDX]
  droplets_data[:droplets] << droplet_info
end

puts droplets_data
