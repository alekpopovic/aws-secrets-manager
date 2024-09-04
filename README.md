# aws-secrets-manager

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add aws-secrets-manager

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install aws-secrets-manager

## Usage

If you using Ruby on Rails then rails g aws-secrets-manager:install

or manualy add in Rack app config file:

```ruby
require 'aws_secrets_manager'

AwsSecretsManager.configure do |config|
  config.aws_region = "AWS_REGION"
end

AwsSecretsManager.get_secret_value(secrets: [
  {
    name: "secret_name",
    type: "plaintext"
  },
  {
    name: "secret_name",
    type: "key_value"
  }]
)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/alekpopovic/aws-secrets-manager. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/alekpopovic/aws-secrets-manager/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the aws-secrets-manager project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/alekpopovic/aws-secrets-manager/blob/main/CODE_OF_CONDUCT.md).
