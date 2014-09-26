require "bunny"

connection = Bunny.new
connection.start

channel = connection.create_channel
exchange = channel.fanout("test.spnee.generic", :passive => true)

exchange.publish("Ping 201")

sleep 3.5
puts "Disconnecting..."
connection.close
