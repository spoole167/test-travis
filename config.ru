require 'dashing'
require 'rest-client'

configure do
  set :auth_token, 'YOUR_AUTH_TOKEN'

  helpers do
    def protected!
     # Put any authentication code you want in here.
     # This method is run before accessing any resource.
    end
  end

  @vcap_application = JSON.parse(ENV['VCAP_APPLICATION'] || '{}')
  @mode = ENV['mode']
  case @mode
  when 'master-server'
    puts "master mode enabled"
  when 'team-server'
    puts "team mode enabled"
  else
   @mode='master-server'
    puts "server mode default mode chosen"
  end

end


map Sinatra::Application.assets_prefix do
  run Sinatra::Application.sprockets
end

run Sinatra::Application
