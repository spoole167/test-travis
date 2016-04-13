#
# These are sinatra rest api definitions
# note dashing reserves /<name> for refering to dashboards
#

get '/api/v1/version' do
  "1.0"
end

get '/api/v1/metrics' do
  content_type :json
  DB.metrics.to_json
end

# put to update metrics for a specific product
# metric data is in the body in json format as well as a key

put '/api/v1/metric' do

  content_type :json

  begin
    data=JSON.parse(request.body.read)
  rescue
    return metricUpdateError(400,001,"invalid json data")
  end

  return metricUpdateError(403,101,"no key present") if !data.key?('key')
  return metricUpdateError(400,102,"no team id present") if !data.key?('team')
  return metricUpdateError(400,103,"no product id present") if !data.key?('product')
  return metricUpdateError(400,104,"no metrics element present") if !data.key?('metrics')

  # apparently valid data elements present - does it make a valid request?

  # find team entry and check key
  return metricUpdateError(403,205,"invalid key for team #{data['team']}") if !validKey?(data['key'],data['team'])

  # check metrics data is well formed..

  # keys must be in valid set

  metrics=data['metrics']
  keys=metrics.keys

  Metrics.columns.each do |c|
    keys.delete(c[:id])
  end

  if keys.length > 0 then
    return metricUpdateError(403,207,"invalid metrics keys #{keys}")
  end

  # field data names must be valid

  metrics.each do |k,v|

      if v.is_a?(Hash)==false then
        return metricUpdateError(403,208,"invalid metrics entry for #{k}")
      end

      # does it have expected fields? (we reject unexpected fields but do not check for all fields being present)
      fieldkeys=v.keys
      fieldkeys.delete("active")
      fieldkeys.delete("trend")
      fieldkeys.delete("value")
      if fieldkeys.length > 0 then
        return metricUpdateError(403,209,"invalid metric fields #{fieldkeys} for metric #{k}")
      end
  end

  # valid key and team etc- lets try to update the product doc
  result=DB.setMetric(data['team'],data['product'],data['metrics'])

  return metricUpdateError(400,207,"Update failed. No product document #{data['product']} for team #{data['team']} ") if result==false

  # otherwise all was good

  status 200

  return {status: 200}.to_json

end


get '/api/v1/teams' do
  content_type :json
  DB.teams.to_json
end

get '/api/v1/refresh' do
  DashboardUpdate.update
  "ok"
end

#
# Checks to see if the key is non blank and matches the one in the team doc
# (assuming there is a team doc)
#
# returns false for invalid conditions

def validKey?(key,team)

  return false if key==nil || key.strip! == ''

  teamdoc=DB.getTeam(team)

  return false if  teamdoc==nil

  team_key=teamdoc['key']

  return team_key==key


end



def metricUpdateError(stat,code,error)
  content_type :json
  status stat
  puts "error called #{stat} #{code} #{error}"
  return {errors: [status:stat , code: code, title: error] }.to_json

end
