require 'bunny'

require_relative './options'
require_relative './publisher'

class Sim
  def run(options)
    connection = Bunny.new
    connection.start

    channel = connection.create_channel
    exchange_name = options.e
    exchange = channel.fanout(exchange_name, :passive => true)

    pub = Publisher.new
    pub.publish(options,exchange)

    sleep 3.5
    connection.close
  end
end

mysim = Sim.new
myoptions = Options.new
options = myoptions.parse(ARGV)
if options.verbose == true
  puts options
end
mysim.run(options)
