#
# Dashboard update logic
#
 class DashboardUpdate


   def self.updateMetric(product_id,metric,data)
      #puts "sending #{product_id}-#{metric} ==> #{data}"
       # note pulling out of value field - this is so Dashing widget can do heavy lifting
       send_event("#{product_id}-#{metric}", { metric: data , summary: Metrics.summaryMode?})

   end

   def self.update

     DB.products.each do |product|
       product_id=product['_id'] || "?"
       metrics=product['metrics'] || {}
       metrics.each do |metric_name,v|
          updateMetric(product_id,metric_name,v)
      end
     end

  end

  def self.publishUpdate(team,product,metrics)

    SCHEDULER.in '1s' do
      metrics.each do |k,v|
        DashboardUpdate.updateMetric("product-#{team}-#{product}",k,v)
      end
        # send on event if running on team server
        DashboardUpdate.propagateMetrics(team,product) if Metrics.teamMode?

    end


  end

  # sends an update to the main server.

  def self.propagateMetrics(team,product)
      puts "sending data upstream"
      metrics=DB.productMetrics(team,product)
      # get upstream url
      url="#{Metrics.summaryURL}/api/v1/metric"
      serverkey="qwerty100"
      body={ key: serverkey , product: product , team: team , metrics:metrics}
      begin
      RestClient.put url, body.to_json, :content_type => :json, :accept => :json
    rescue => e
        puts "update failed #{e}"
      end
  end

 end
