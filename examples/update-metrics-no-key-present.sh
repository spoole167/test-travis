# should return a 403
curl -s -o /dev/null -w "%{http_code}" -H "Content-Type: application/json" -X PUT -d '{"a":"xyz","b":"xyz"}' http://192.168.99.100/api/v1/metric
