# SmartyAddress

Validate and format addresses via Smarty API (https://www.smarty.com)

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add smarty_address

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install smarty_address

## Usage

Pipe contents of a file to the executable.

    $ cat file.csv | smarty_address

Pass a filename to the executable.

    $ smarty_address file.csv

In an application, call methods directly on the SmartyAddress classes.

    $ SmartyAddress.print_formatted_addresses(data)

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

Make sure to `cp .env.example .env` and replace the environment variables with your own.

To test the executable with your local changes, execute the executable with ruby explicitly like `ruby -Ilib bin/smarty_address file.csv`

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/smarty_address. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/smarty_address/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the SmartyAddress project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/smarty_address/blob/master/CODE_OF_CONDUCT.md).
