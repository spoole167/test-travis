# agile-metrics-dashboard [![Chat](https://img.shields.io/badge/chat-on%20slack-brightgreen.svg)](https://cid-eacs.slack.com/messages/metrics/)
Dashing based metrics server

Example:
![](./examples/Agile Metrics Dashboard example.jpg)

The project presents product team metrics using dashing

Metric values are retrieved from a couchdb database

To run the server the first time, make sure you have the latest Docker runtime, and then run:

dashboard up

This will pull in and build the container images and run two containers:
db
web

Visit 192.168.99.100:3030 to see the results

Template documents are added to couchdb to be expanded upon by the server admin

Data is stored in various couchdb documents in a 'metrics' database.  There is a two tier structure that is intended to allow product teams to run their own server (with modified metrics) and feed into a central cross team version

Template documents are held in  doc-templates
