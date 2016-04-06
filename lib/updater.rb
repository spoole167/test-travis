#
# Dashboard update logic
#
 class DashboardUpdate


   def self.productUpdateFailed(product,errorText)
       name=product['name']
       send_event("#{name}-status", { label: errorText })
   end

   def self.updateProduct(product,metrics)

     product_name=product['name']
     metrics.each do |m|
        metric_name=m['name']
        metric_value=m['value']
        send_event("#{product_name}-#{metric_name}", { label: metric_value })
    end

   end


   def self.update


     DB.products.each do |product|


        url=product['url']
        if url !=nil

          begin

           response = RestClient.get "#{url}"

           if response.code == 200
            updateProduct(product,JSON.parse(response.body))
          else
            productUpdateFailed(product,"server response unexpected #{response.code}")
          end

        rescue => e
           productUpdateFailed(product,"invalid response from product server #{e}")
         end

        else
            productUpdateFailed(product,"no server url defined")
        end

     end

  end

 end
