require 'fog/core/model'

class OpenStackRainbowsExtension
  class Unicorn < Fog::Model
    identity :id
    attribute :name
    attribute :horn_length
  end
end
