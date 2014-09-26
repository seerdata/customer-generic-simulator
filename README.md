The simulator assumes that you have RabbitMQ installed on the local
instance where you will be running the simulator.

To install RabbitMQ go here

http://www.rabbitmq.com/download.html

To install the simulator

```
git clone git@github.com:stormasm/spinnakr-generic-simulator.git
bundle install
```

**To run the simulator you must be in the lib directory**

To see the options that you can pass into the simulator:

```
ruby sim.rb -h
```

#### Verbosity

All output from the simulator is available in verbose mode

```
ruby sim.rb -v
```

#### Exchange Name

The default exchange name where events get published is **test.spnee.generic**

To define an alternate exchange name to publish to

```
ruby sim.rb -e 'test.spnee.generictwo'
```

#### Messages

The default number of messages that get published out is 2

To publish out more than 2 messages and instead publish 10 messages

```
ruby sim.rb -n 10
```


#### Iterations

You have the option of publishing n messages once and only once.

However, you can also publish n messages i times by defining the number of iterations.

If you decide to publish 6 messages inside 4 iterations then you would run this command

```
ruby sim.rb -v -n 6 -i 4
```

#### Sleep

By default the publisher sleeps for 10 seconds after each iteration, if you want to only
sleep for 3 seconds instead of 10 seconds you would issue this command

```
ruby sim.rb -v -n 6 -i 4 -s 3
```

#### Forever

The simulator also gives you the ability to run forever.  If you decide you want to publish for
eternity then simply pass in the forever flag.

```
r sim.rb -v -n 6 -i 4 -s 3 -f
```

#### Time

Each event has a timestamp associated with it.  To simulate a period of time over n days you pass
in a flag which tells the simulator what day range you want to simulate.

The default day interval is **10 days**.  Meaning the time stamps will have a min time
of 10 days ago and a max time of 10 days from now.

If you want to simulate 20 days forward and 20 days back then pass in the **d** flag.

```
r sim.rb -d 20
```

#### Dimension String

By default the dimension string is **visit-useragent**.

You can see that by issuing this command and looking at the verbose output

```
ruby sim.rb -v
```

If you want a different dimension string then you can issue these commands

```
ruby sim.rb -m visit-uuid
ruby sim.rb -m job-skills
```

#### Extra examples

This will publish 20 messages once and only once to an alternate exchange.

```
ruby sim.rb -n 20 -e 'test.spnee.generictwo'
```

Of course you can always just run the default publisher simply with this command

```
ruby sim.rb
```
