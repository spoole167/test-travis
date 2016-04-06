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

  key="products"

  begin
    doc=@metricsdb.get(key)

  rescue
    doc={ _id: key , products: [ { id: 'base' , name: 'Base Product' }] }
    @metricsdb.save_doc(doc)

  end

  doc['products']

end

def self.teams

  key="teams"

  begin
    doc=@metricsdb.get(key)

  rescue
    return []
  end

  doc['teams'] || []

end


def self.hasTeamsDoc?

  key="teams"

  begin
    doc=@metricsdb.get(key)

  rescue
    return false

  end

  return true

end


def self.metrics

    metrics=[]

    products.each do |p|
        puts "get metric for product #{p}"
        metrics << productMetrics(p['id'])
    end

  metrics

end

#
# returns metric data for specific product
#

def self.productMetrics(product)

  # get metrics data
  key="#{product}"
  begin
    doc=@metricsdb.get(key)
  rescue
    doc={ _id: key, product: product,name: product, metrics: {} }
    # add metric fields
    Metrics.columns.each do |c|
      doc[:metrics][c[:id]]={active: true, trend: 0 , value: "n/a"}
    end
    @metricsdb.save_doc(doc)

  end

  doc

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
