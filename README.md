# agile-metrics-dashboard [![Chat](https://img.shields.io/badge/chat-on%20slack-brightgreen.svg)](https://cid-eacs.slack.com/messages/metrics/)
## Dashing based metrics server

Example:

![](./examples/Agile Metric Dashboard example.jpg)

The project presents product team metrics using dashing

Metric values are retrieved from a couchdb database

To run the server the first time, make sure you have the latest [Docker toolbox] (https://www.docker.com/products/docker-toolbox), 
use the Docker Quickstart Shell and then run from the top-level directory of this clone:

./dashboard up

This will pull in and build the container images and run four containers:

* dbserver - the summary database of team/products
* dbteam - a team/products database
* web - the team dashboard web app
* summary - the summary dashboard web app

Visit http://192.168.99.100:8080 (which is the docker VM containers address on your machine) to see the results of the summary dashboard and
http://192.168.99.100/ for the dashboard of the team server.

When finished, close it down with:

./dashboard down

Template documents are added to couchdb to be expanded upon by the server admin

Data is stored in various couchdb documents in a 'metrics' database.  There is a two tier structure that is intended to allow product teams to run their own server (with modified metrics) and feed into a central cross team version

Template documents are held in  doc-templates
