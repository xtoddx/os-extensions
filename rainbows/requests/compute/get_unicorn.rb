class OpenStackRainbowsExtension

  class Real < Fog::Compute::OpenStack::DelegateRequestClass
    def get_unicorn(unicorn_id)
      request(:expects => [200, 203],
              :method => "GET",
              :path => "unicorn/#{bar_id}.json")
    end
  end
  
  class Mock
    def get_unicorn(unicorn_id)
      response = Excon::Response.new
      response.status = 200
      response.body = {'unicorn' => [ {'id' => unicorn_id, 'name' => 'Elise',
                                       'horn_length' => '0.2'} ]}
      response
    end
  end

end
