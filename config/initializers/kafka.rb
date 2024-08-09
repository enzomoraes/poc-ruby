# config/initializers/kafka.rb
require 'rdkafka'

$kafka = Rdkafka::Config.new({
  'bootstrap.servers': 'localhost:9092',
  'client.id': 'my-application'
}).producer
