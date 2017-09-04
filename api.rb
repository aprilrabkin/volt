require_relative 'config/environment'
require 'yaml'
env_vars = YAML.load_file('secrets.yml')
DB = Sequel.connect("postgres://#{env_vars['db_user']}:#{env_vars['db_password']}@#{env_vars['db_hostname']}/#{env_vars['db_name']}")

class Api < Sinatra::Base
  get '/hello' do
    halt 400 unless params[:name]
    content_type :json
    status 200
    { "message": "Hello #{params['name']}" }.to_json
  end

  get '/readings/:sensor_id' do 
    halt 400 unless params[:sensor_id]
    sensor_id = params[:sensor_id].to_i

    readings = DB[:readings].where("sensor_id=#{sensor_id}")
    readings = readings.order(:timestamp).map do |r|
          { 
            "timestamp": r[:timestamp],
            "value": r[:value]
          }
        end
    status 200
    { 
      "sensor_id": params[:sensor_id],
      "readings": readings
    }.to_json
  end

  post '/readings' do
    payload = JSON.parse(request.body.read)
    sensor_id = payload["sensor_id"].to_i
    new_records =  payload["readings"].map do |r|
        [sensor_id,r["timestamp"],r["value"]]
      end
    DB[:readings].import([:sensor_id, :timestamp, :value], new_records)
    status 201
  end
end