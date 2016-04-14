#
# General Metrics helper classes - see dashboards for use
#

class Metrics


  def self.metricNames
    return StandardMetrics.metrics+TeamMetrics.metrics if teamMode?
    return StandardMetrics.metrics
  end

  def self.teamMode?

    ENV['MODE']=='team'

  end

  def self.summaryMode?

      ENV['MODE']=='summary'

    end

end
