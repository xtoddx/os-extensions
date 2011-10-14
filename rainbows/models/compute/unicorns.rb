require 'fog/core/collection'
require 'rainbows/models/compute/unicorn'

class OpenStackRainbowsExtension
  class Unicorns < Fog::Collection
    model OpenStackRainbowsExtension::Unicorn

    def all(rainbow_id=nil)
      # param must be optional because all is called by lazy_load w/o params
      if rainbow_id
        # when given, should get real data
        data = connection.list_unicorns(rainbow_id).body['rainbows']
      else
        # otherwise be fake with no entries
        load([])
      end
    end

    def get(unicorn_id)
      # detailed view of unicorns
      data = connection.get_unicorn(unicorn_id).body['unicorn']
      new(data)
    rescue Fog::Compute::OpenStack::NotFound
      nil
    end
  end
end
