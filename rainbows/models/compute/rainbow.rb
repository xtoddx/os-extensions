require 'fog/core/model'

class OpenStackRainbowsExtension
  class Rainbow < Fog::Model
    identity :id
    attribute :name
    attribute :double
  end
end
