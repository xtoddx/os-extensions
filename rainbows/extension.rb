require 'fog/openstack/compute'

class OpenStackRainbowsExtension < Fog::Compute::OpenStack::DelegateService
  model_path 'rainbows/models/compute'
  model :rainbow
  collection :rainbows
  model :unicorn
  collection :unicorns

  request_path 'rainbows/requests/compute'
  request :list_rainbows
  request :list_unicorns # arg: rainbow_id
end

Fog::Compute::OpenStack.add_delegate(OpenStackRainbowsExtension)
