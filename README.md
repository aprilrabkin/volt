# Volt

An exercise in deploying a simple web app with database to the cloud. (Used AWS EC2 and RDS with Passenger standalone as web server and app server.)

### Development:
```
bundle install
rackup
```

### Database setup

Start a postgres server and add db_user, db_password, db_hostname, and db_database name to secrets.yml.

```
create table readings (
  sensor_id integer not null,
  timestamp timestamp without time zone not null,
  value real not null);
  ```


### Example requests

Change IP to localhost for development

```
curl -v http://18.221.45.7/readings/1

curl -H "Content-Type: application/json" -X POST -d '{"sensor_id": "1","readings": [{"timestamp": "2017-08-31T18:04:00Z", "value": 111.0}, {"timestamp": "2017-08-31T18:05:00Z", "value": 222.0}, {"timestamp": "2017-08-31T18:06:00Z", "value": 333.0}]}' http://18.221.45.7/readings
  ```
