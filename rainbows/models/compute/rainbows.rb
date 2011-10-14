require 'fog/core/collection'
require 'rainbows/models/compute/rainbow'

class OpenStackRainbowsExtension
  class Rainbows < Fog::Collection
    model OpenStackRainbowsExtension::Rainbow

    def all
      data = connection.list_rainbows.body['rainbows']
      load(data)
    end

  end
end
