class OpenStackRainbowsExtension

  class Real < Fog::Compute::OpenStack::DelegateRequestClass
    def list_rainbows
      request(:expects => [200, 203],
              :method => 'GET',
              :path => 'rainbows.json')
    end
  end
  
  class Mock
    def list_rainbows
      response = Excon::Response.new
      response.status = 200
      response.body = {'rainbows' => [
                           {'id' => 1, 'name' => 'Beta-bow', 'double' => '0'} ]}
      response
    end
  end

end
