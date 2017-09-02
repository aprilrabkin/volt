docker build -t api .

docker run --rm -it -p 9292:9292 \
  -e DB_USER="volt" \
  -e DB_PASSWORD="password" \
  -e DB_HOSTNAME="localhost" \
  -e DB_NAME="volt" \
  api
