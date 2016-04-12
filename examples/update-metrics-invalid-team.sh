# key present only should return 400 (missing product)
curl -s -o /dev/null -w "%{http_code}" -H "Content-Type: application/json" -X PUT -d '{"key":"xyz","product":"p","team":"t","metrics":[]}' http://192.168.99.100/api/v1/metric
