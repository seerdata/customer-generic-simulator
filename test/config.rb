require 'yaml'

class MyConfig

  def initialize
    @config = YAML.load_file("./config.yml") rescue nil || {}
  end

  def init_config
    puts @config
    puts; puts
    puts @config['config']['amqp_server']
  end
end

myconfig = MyConfig.new
myconfig.init_config
