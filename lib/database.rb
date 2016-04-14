# code to support reading and writing to Couchdb

require 'couchrest'

# helper from http://stackoverflow.com/questions/4505743/couchrest-checking-if-document-id-exists
def save_or_create(db, doc)
    begin
      rev = db.get(doc['_id'])['_rev']
      doc['_rev'] = rev
      db.save_doc(doc)
    rescue RestClient::ResourceNotFound => nfe
      db.save_doc(doc)
    end
end

# find default docs and add to database if missing
def addDefaultDocs(db)

    puts "Adding default docs using mode=#{ENV['MODE']}"
    Dir["default-doc/#{ENV['MODE']}/*.json"].entries.each do |f|
      data=JSON.parse(File.new(f).read)
      begin
        key=data['_id']
        doc=@metricsdb.get(key)
      rescue
        #missing
        puts "adding document #{f}"
        @metricsdb.save_doc(data)
      end

    end

end

def addViews(db)

    # add a view for products only (_id='product-*')

    prodlist = {
    :map => 'function(doc){
      var parts = doc._id.split(/-/);
      if (parts[0]==\'product\') emit(doc)
    }'
  }

  # add a view for team / products
  teamlist = {
  :map => 'function(doc){
    var parts = doc._id.split(/-/);
    if (parts[0]==\'product\') emit(parts[1],doc)
  }'
}

  save_or_create(@metricsdb,{
    "_id" => "_design/products",
    :views => {
      :products => prodlist,
      :teams => teamlist
    }
  })


end


class DB

# look for config for bluemix
# https://console.ng.bluemix.net/docs/services/Cloudant/index.html#cloudant_003

cloudant_config = JSON.parse(ENV['VCAP_SERVICES'] || '{}')['cloudantNoSQLDB']

if cloudant_config!=nil
  url=cloudant_config[0]['credentials']['url']
else
  # if not found assume local Docker network open connection to couchdb
  url=ENV['DBURL']
end

# connect and create database if missing
@metricsdb=CouchRest.database!("#{url}/metrics/")

puts "database connection established [#{@metricsdb.host}]"
puts "#{@metricsdb.info}"

addDefaultDocs(@metricsdb)

addViews(@metricsdb)

#
# returns all product docs
#
def self.products

  results=@metricsdb.view("products/products")['rows']
  results.map {|row| row['key']}

end

def self.teamdata
  results=@metricsdb.view("products/teams")['rows']
  results.group_by { | k | k['key']}

end

#
# Return list of registered teams -  summary mode only
#
def self.teams

  begin
    doc=@metricsdb.get("teams")
  rescue
    return []
  end

  doc['teams'] || []

end


def self.getTeam(team)

  key="team-#{team}"

  begin
    doc=@metricsdb.get(key)

  rescue
    return nil

  end

  return doc


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

def self.productMetrics(team,product)

  # get metrics data
  key="product-#{team}-#{product}"
  begin
    data= @metricsdb.get(key)
  rescue
    data={}
  end

  data['metrics'] || {}

end

#
# sets the value for a specific metric for a specific product
#
def self.setMetric(team,product,new_metrics)

  begin

  key="product-#{team}-#{product}"
  doc=@metricsdb.get(key)
  return false if doc==nil

  # get metrics or add an empty set
  existing_metrics=doc['metrics']
  if existing_metrics==nil
    existing_metrics={}
    doc['metrics']=existing_metrics
  end

  # for each new value update existing metrics

  new_metrics.each do |k,v|
      existing_metrics[k]=v
  end

  # save doc
  doc.save

  return true

  rescue

    return false

  end

end

end
