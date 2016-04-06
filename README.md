Dashing based metrics server

The project presents product team metrics using dashing

Metric values are retrieved from a couchdb database

To run the server the first time

Install couchdb

Install all required ruby packages

bundle install
./local.sh

Visit localhost:3030 to see the results

Template documents are added to couchdb to be expanded upon by the server admin

Data is stored in various couchdb documents in a 'metrics' database.  There is a two tier structure that is intended to allow product teams to run their own server (with modified metrics) and feed into a central cross team version

Template documents are held in  doc-templates
