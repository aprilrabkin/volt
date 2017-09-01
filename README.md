# DB setup
DB.run("drop table if exists readings")

DB.run("create table readings (
  sensor_id integer not null,
  timestamp timestamp without time zone not null,
  value real not null)")

# Example requests
curl -v http://127.0.0.1:9393/readings/1

curl -H "Content-Type: application/json" -X POST -d '{"sensor_id": "1","readings": [{"timestamp": "2017-08-31T18:04:00Z", "value": 111.0}, {"timestamp": "2017-08-31T18:05:00Z", "value": 222.0}, {"timestamp": "2017-08-31T18:06:00Z", "value": 333.0}]}' http://127.0.0.1:9393/readings

#To Do
create aws pg rds
create aws ec2

add pg database volt and user volt
