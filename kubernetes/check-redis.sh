until nc -z -v -w30 $REDIS_HOST 6379
do
  echo "Waiting for redis connection..."
  sleep 1
done
echo "Connected to Redis"

