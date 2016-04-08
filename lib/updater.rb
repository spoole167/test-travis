#
# Dashboard update logic
#
 class DashboardUpdate


   def self.updateMetric(team,product,metric,data)

       # note pulling out of value field - this is so Dashing widget can do heavy lifting
       send_event("#{team}-#{product}-#{metric}", { metric: data , summary: true})

   end

   def self.update

     Metrics.products.each do |product|
       team_name=product['team'] || 'local'
       product_name=product['product'] || 'base'
       metrics=product['metrics'] || {}
       metrics.each do |metric_name,v|
          updateMetric(team_name,product_name,metric_name,v)
      end
     end

  end

 end
