#
# General Metrics helper classes - see dashboards for use
#
class Metric
    def initialize(m)
      @metric=m
    end

    def active?
      @metric['active'] || true
    end

    def direction
      trend=@metric['trend'] || 0
      return "forward"   if trend > 0
      return "reverse"     if trend < 0
      return "neutural"
    end

    def value
      return "" if !active?
      @metric['value'] || 'N/A'
    end

    def icon

      return "" if !active?

      trend=@metric['trend'] || 0
      return "play"   if trend > 0
      return "backward"     if trend < 0
      return "pause"
    end
end


class Metrics

  def self.columns
      return StandardMetrics.metrics if mode=='summary'
      return StandardMetrics.metrics+TeamMetrics.metrics
  end


  def self.format(product,column)

    return Metric.new({ trend: 0 , active: false}) if product==nil || column==nil || product[column]==nil
    return Metric.new(product[column])

  end

  def self.products

    products=[]

    # in summary mode visit all the servers to get the data
    # should make this async at some point

    if mode=='summary'
      DB.teams.each do |t|
          metricsurl=t['url']
          team_entries=get("#{metricsurl}")
          products=products.concat(team_entries) unless team_entries==nil
      end

    else
      products=DB.products || []
    end

    products

  end


  def self.mode

    return 'team'    if ENV['mode']=='team'
    return 'summary' if ENV['mode']=='summary'

    return 'summary' if DB.hasTeamsDoc?
    return 'team'
  end

  def self.get (url)

    puts "internal rest call to #{url}"

    begin

     response = RestClient.get "#{url}"
     puts "response= #{response}"

     if response.code == 200
       return JSON.parse(response.body)
    else
      return nil
    end

  rescue => e
     puts "failed #{e}"
     return nil
   end

 end

end
