#
# APIs for showing data editors
#
get '/edit/summary' do
  # display summary (all teams) editor (without the dashing css style etc)
  erb :summary_editor , :layout => false
end

get '/edit/team' do
  # display product team  editor (without the dashing css style etc)
  erb :team_editor , :layout => false
end
