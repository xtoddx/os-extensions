#!/usr/bin/ruby

$: << '../fog/lib'
$: << '.'
require 'fog'
require 'rainbows/extension'

keystone = "http://localhost:5000/v2.0/tokens"
user = "admin"
pass = "password"
tenant = nil

compute = Fog::Compute.new(:provider => 'OpenStack',
                           :openstack_auth_url => keystone,
                           :openstack_username => user,
                           :openstack_api_key =>  pass,
                           :openstack_tenant => tenant)

# Just to make sure things work the way they should
images = compute.images
puts "Number of images: #{images.length}"

# Use the collection to send the request
rv = compute.rainbows
puts "Number of rainbows: #{rv.length}"
