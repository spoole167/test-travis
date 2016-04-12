SCHEDULER.every '60m', :first_in => '30s' do

  DashboardUpdate.update

end
