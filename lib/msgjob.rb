require_relative './msgbase'
require_relative './timesim'

class Msgjob < Msgbase

  def initialize(options)
    @timesim = TimeSim.new
    @options = options
  end

  def get_key
    ['ios','android','java','python','ruby'].sample
  end

  def get_value
    (1..10).to_a.sample
  end

  def get_interval
    ['weeks','months']
  end

  def get_calculation
    ['sum','average']
  end

  def buildmsg
    msg_hash = Hash.new
    msg_hash[:token_id] = get_token_id
    dimension = get_dimension
    msg_hash[:dimension] = dimension
    msg_hash[:key] = get_key
    msg_hash[:value] = get_value

    # Publish out a random time on either side of day interval
    msg_hash[:created_at] = @timesim.get_random_time(@options.d)

    # Publish out the time now
    # msg_hash[:created_at] = Time.now

    msg_hash[:interval] = get_interval
    msg_hash[:calculation] = get_calculation
    msg_hash
  end

  def build_n_messages(n)
    messages = []
    for i in 0..n
      mymsg = buildmsg
      messages.push(mymsg)
    end
    messages
  end
end

=begin
require_relative './options'
myoptions = Options.new
options = myoptions.parse(ARGV)
msg = Msgjob.new(options)
puts msg.buildmsg
=end

=begin
require_relative './options'
myoptions = Options.new
options = myoptions.parse(ARGV)
msg = Msgjob.new(options)
n = 3
msgs = msg.build_n_messages(n)
for i in 0..n
  puts msgs[i]
end
=end
