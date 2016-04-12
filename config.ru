require 'dashing'
require 'rest-client'

configure do
  set :default_dashboard, ENV['MODE']

end


map Sinatra::Application.assets_prefix do
  run Sinatra::Application.sprockets
end

run Sinatra::Application
