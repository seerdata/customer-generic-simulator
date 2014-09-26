require 'securerandom'
require_relative './msgbase'
require_relative './timesim'

class Msgvisit < Msgbase

  def initialize(options)
    @timesim = TimeSim.new
    @options = options
  end

  def get_method
    @options.b
  end

  def get_key(method)
    if method == 'uuid'
      get_my_visit_uuid
    elsif method == 'useragent'
      ['mozilla','chrome','safari'].sample
    else
      'none'
    end
  end

  def get_value(method)
    if method == 'uuid'
      1
    elsif method == 'useragent'
      (1..10).to_a.sample
    else
      (10..20).to_a.sample
    end
  end

  def get_interval(method)
    if method == 'uuid'
      interval = ['hours','days']
    elsif method == 'useragent'
      interval = ['weeks']
    else
      interval = ['hours','days','weeks']
    end
  end

  def get_calculation(method)
    if method == 'uuid'
      calculation = ['sum','average']
    elsif method == 'useragent'
      calculation = ['sum','average','percentage']
    else
      calculation = ['regression']
    end
  end

  def get_my_random_visit_uuid
    my_visit_uuid = []
    for i in 0..10
      my_visit_uuid.push(SecureRandom.uuid)
    end
    #puts my_visit_uuid.sort
    #puts
    my_visit_uuid
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
    msg_hash[:token_id] = get_token_id
    dimension = get_dimension
    method = get_method
    msg_hash[:dimension] = dimension
    msg_hash[:key] = get_key(method)
    msg_hash[:value] = get_value(method)

    # Publish out a random time on either side of day interval
    msg_hash[:created_at] = @timesim.get_random_time(@options.d)

    # Publish out the time now
    # msg_hash[:created_at] = Time.now

    msg_hash[:interval] = get_interval(method)
    msg_hash[:calculation] = get_calculation(method)
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
msg = Msgvisit.new(options)
puts msg.buildmsg
=end

=begin
require_relative './options'
myoptions = Options.new
options = myoptions.parse(ARGV)
msg = Msgvisit.new(options)
n = 5
msgs = msg.build_n_messages(n)
for i in 0..n
  puts msgs[i]
end
=end
