require_relative './msgbase'
require_relative './timesim'

class MsgUUID < Msgbase

  def initialize(options)
    @timesim = TimeSim.new
    @options = options
  end

  def get_key
    get_my_visit_uuid
  end

  def get_value
    ['1.01','2.02','3.03','4.04','5.05','6.06','7.07','8.08','9.09','10.10'].sample
  end

  def get_interval
    ['hours','weeks','months']
  end

  def get_calculation
    ['count','sum','average','standard_deviation','linear_regression']
  end

  def get_my_visit_uuid
    my_visit_uuid = [
      '404a5866-b844-4186-9322-59cacdcec297',
      '45f32255-aaeb-4d2f-8988-26494bc4d58d',
      '5c953ea8-a620-45bf-8959-6feee5d57c33',
      '667677c9-9d1c-4162-ad80-d8e22f2fb2a8',
      'c8c78c01-869b-4295-869c-8d93039ac379',
      'b45b81f2-334a-40f6-9d3c-8d1c8a42bfdf',
      'd16de577-f454-4f6a-9b54-9a9f7d05fc5c',
      'dd47e62d-b9bb-492d-b9d6-b033fb6d2b94',
      'df063345-f168-4948-bc90-ee816b13b254',
      'ee88784e-b900-4947-a387-959b582f3dd1',
    ].sample
  end

  def buildmsg
    msg_hash = Hash.new
    msg_hash[:access_token] = get_token_id
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
