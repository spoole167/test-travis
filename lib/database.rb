# code to support reading and writing to Couchdb

require 'couchrest'

class DB

# look for config for bluemix
# https://console.ng.bluemix.net/docs/services/Cloudant/index.html#cloudant_003

cloudant_config = JSON.parse(ENV['VCAP_SERVICES'] || '{}')['cloudantNoSQLDB']

if cloudant_config!=nil
  url=cloudant_config['credentials']['url']
else
  # if not found assume local open connection to couchdb
  url="http://localhost:5984/"
end

# connect and create database if missing
@metricsdb=CouchRest.database!("#{url}/metrics/")

puts "database connection established [#{@metricsdb.host}]"


#
# returns all products
#
def self.products

  doc=@metricsdb.get('products') || { products: [] }

  doc['products']

end

#
# returns metric data for specific product
#
def self.metrics(product)
  puts "product=#{product}"
  # get metrics data
  doc=@metricsdb.get(product) || { product: product, metrics: {} }
  doc['metrics']
end

#
# sets the value for a specific metric for a specific product
#
def self.setMetric(product,metricid,data)

  doc=@metricsdb.get(product)
  return nil if doc==nil

  metrics=doc['metrics']

  metrics[metricid]=data

  @metricsdb.update_doc(doc)


end

end
