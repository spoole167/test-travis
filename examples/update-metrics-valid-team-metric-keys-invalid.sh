# 'bad' metric keys
curl -s -o /dev/null -w "%{http_code}" -H "Content-Type: application/json" -X PUT -d '{"key":"test","product":"base1","team":"test","metrics":{"_devlead":{"trend":"0","active":"0"},"foobar":{"trend":"0","active":"0"},"foobar2":{"trend":"0","active":"0"}}}' http://192.168.99.100/api/v1/metric
