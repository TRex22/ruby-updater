# ruby-updater
A tool to combine PDF tools, OCR tools and image processing into a
single interface as both a CLI and a library.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ruby-updater'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ruby-updater

### Other required dependencies
You will need to install `tesseract` with your desired language on your system,
`pdftoppm` needs to be available and also `image-magick`.

## Usage
```ruby
  require 'ruby-updater'


```

### Simple CLI
Once installed you can use `ruby-updater` as a CLI. Its currently a reduced set of options. These are subject to change in future versions

```
# Basic Usage with console output

```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

### TODOs
- Run tests
- Auto commit
- yarn and package.json

### Tests
To run tests execute:

    $ rake test

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/trex22/ruby-updater. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the ruby-updater: project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/trex22/ruby-updater/blob/master/CODE_OF_CONDUCT.md).
