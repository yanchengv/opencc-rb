# OpenCC

A gem for [OpenCC](https://github.com/BYVoid/OpenCC).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'opencc-rb'
```

And then execute:

```shell
bundle install
```

Or install it yourself as:

```shell
gem install opencc
```

## Usage

```ruby
require 'opencc'

OpenCC.with(:s2t) do |ct|
  ct.convert('漢字') # => '汉字'
end

# same as

OpenCC::Converter.with(:s2t) do |ct|
  ct.convert('漢字') # => '汉字'
end

# Or
converter = OpenCC::Converter.new(:t2s)
converter.convert('汉字') # => '漢字'
converter.close # => true
converter.closed? # => true
converter.close # => false
converter.convert('汉字') # => nil
```
## Known Bugs

- tw2t always return nil ):

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/songjiz/opencc-rb.


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).