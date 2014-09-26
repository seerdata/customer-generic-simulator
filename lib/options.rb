require 'optparse'
require 'ostruct'
require 'pp'

class Options

  def parse_dash(dimension)
    dimension.split('-')
  end

  def parse(args)

    options = OpenStruct.new
    options.forever = false
    options.verbose = false

    options.d = 10
    options.e = "test.spnee.generic"
    options.i = 1
    options.m = "visit-useragent"
    options.n = 2
    options.s = 10
    options.a = "visit"
    options.b = "useragent"

    opt_parser = OptionParser.new do |opts|
      opts.banner = "Usage: sim.rb [options]"

      # Boolean switch.
      opts.on("-f", "Run forever") do |v|
        options.forever = v
      end

      # Boolean switch.
      opts.on("-v", "Run verbosely") do |v|
        options.verbose = v
      end

      # Dimension Options

      opts.on("-m Dimension", "String Dimension name") do |m|
        options.m = m
        type_method = parse_dash(options.m)
        # type
        options.a = type_method[0]
        # method
        options.b = type_method[1]
      end

      opts.on("-e Exchange", "String Exchange name") do |c|
        options.e = c
      end

      # Integer Options

      opts.on("-d Days", Integer, "Integer Time simulation interval") do |x|
        options.d = x
      end

      opts.on("-i Iterations", Integer, "Integer Publish i iterations") do |x|
        options.i = x
      end

      opts.on("-n Messages", Integer, "Integer Publish n messages") do |x|
        options.n = x
      end

      opts.on("-s Seconds", Integer, "Integer Sleep s seconds") do |x|
        options.s = x
      end

      # No argument, shows at tail.  This will print an options summary.
      # Try it and see!
      opts.on_tail("-h", "--help", "Show this message") do
        puts opts
        exit
      end

    end

    opt_parser.parse!(args)
    options
  end
end

#myoptions = Options.new
#puts myoptions.parse(ARGV)
