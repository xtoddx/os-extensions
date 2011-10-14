class OpenStackRainbowsExtension

  class Real < Fog::Compute::OpenStack::DelegateRequestClass
    def list_unicorns(rainbow_id)
      request(:expects => [200, 203],
              :method => 'GET',
              :path => ('unicorns.json?rainbow_id=%i' % rainbow_id))
    end
  end
  
  class Mock
    def list_unicorns
      response = Excon::Response.new
      response.status = 200
      response.body = {'unicorns' => [ {'id' => 1, 'name' => 'Elise'} ]}
      response
    end
  end

end
