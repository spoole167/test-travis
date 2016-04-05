#
# Display helper classes - see dashboards for use
#
class Metric
    def initialize(m)
      @metric=m
    end

    def active?
      @metric['active'] || false
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
      return "thumbs-up"   if trend > 0
      return "thumbs-down"     if trend < 0
      return "minus "
    end
end


class FMT

  def self.metric(data,metric)

    return Metric.new({ trend: 0 , active: false}) if data==nil || metric==nil || data[metric]==nil
    return Metric.new(data[metric])

  end


end
