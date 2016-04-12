#
# Dashboard update logic
#
 class DashboardUpdate


   def self.updateMetric(product_id,metric,data)

       # note pulling out of value field - this is so Dashing widget can do heavy lifting
       send_event("#{product_id}-#{metric}", { metric: data , summary: ENV['MODE']=='summary'})

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

 end
