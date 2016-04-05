#
# These are sinatra rest api definitions
# note dashing reserves /<name> for refering to dashboards
#


get '/api/v1/metrics' do
  content_type :json
  DB.metrics.to_json
end

# put to update metric for a specific product
# metric data is in the body in json format

put '/api/v1/metrics/:product/:metric' do

  content_type :json

  product=params['product']
  metric=params['metric']

  data=JSON.parse(request.body.read)

  result=DB.setMetric(product,metric,data)

  status 404 if result==nil
  status 200 if result!=nil
end


get '/api/v1/teams' do
  content_type :json
  DB.teams.to_json
end

get '/api/v1/refresh' do
  DashboardUpdate.update
  "ok"
end
