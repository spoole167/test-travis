# key present only should return 200 as test team is added to database automatically at server start up.
curl -s -o /dev/null -w "%{http_code}" -H "Content-Type: application/json" -X PUT -d '{"key":"test","product":"base1","team":"test","metrics":[]}' http://192.168.99.100/api/v1/metric
