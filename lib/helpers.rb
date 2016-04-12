#
# General Metrics helper classes - see dashboards for use
#

class Metrics



  def self.mode

    return 'team'    if ENV['MODE']=='team'
    return 'summary' if ENV['MODE']=='summary'

  end

end
