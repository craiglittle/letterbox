# Letterbox

A short-lived actor framework using Celluloid.

## Installation

With Bundler:
```ruby
gem 'letterbox'
```

Otherwise:
```ruby
gem install letterbox
```

## Usage

When instantiating a `Letterbox::Exchange` you must provide a class
that will do the work. The work class' constructor should accept one
argument (the "payload") and implement a `perform` method that performs
the desired work.

You can send work to a particular address by specifying a payload and
the address that should do the work. All work sent to a particular
address will be processed serially.

Work spread across multiple mailboxes will be processed concurrently.

Empty addresses are cleaned up automatically once there is no more work
to be done.

```ruby
module MyWork

  attr_reader :payload

  def initialize(payload)
    @payload = payload
  end

  def perform
    sleep rand
    puts "Working on: #{payload}"
  end

end

e = Letterbox::Exchange.new(MyWork)

# spread 100 units of work across 10 addresses
100.times { |i| e.dispatch("payload #{i}", "a#{i % 10}") }
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/letterbox/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
