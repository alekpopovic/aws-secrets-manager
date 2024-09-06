# aws-secrets-manager

[![Ruby](https://github.com/alekpopovic/aws-secrets-manager/actions/workflows/main.yml/badge.svg)](https://github.com/alekpopovic/aws-secrets-manager/actions/workflows/main.yml)

[![Ruby Gem](https://github.com/alekpopovic/aws-secrets-manager/actions/workflows/gem-push.yml/badge.svg)](https://github.com/alekpopovic/aws-secrets-manager/actions/workflows/gem-push.yml)

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add aws-secrets-manager

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install aws-secrets-manager

## Usage

If you using Ruby on Rails then 

```ruby
rails g aws_secrets_manager:install
```

or manualy add in Rack app config file:

```ruby
# frozen_string_literal: true

require 'aws_secrets_manager'

AwsSecretsManager.configure do |config|
  config.aws_region = ENV.fetch('AWS_REGION', 'eu-west-1')
end

AwsSecretsManager.get_secret_value(
  secrets: [
    {
      name: ENV.fetch('AWS_SECRETS_PLAINTEXT_1', 'aws-secrets-plaintext-1-development'),
      type: AwsSecretsManager::Config::PLAINTEXT
    },
    {
      name: ENV.fetch('AWS_SECRETS_PLAINTEXT_2', 'aws-secrets-plaintext-2-development'),
      type: AwsSecretsManager::Config::PLAINTEXT
    },
    {
      name: ENV.fetch('AWS_SECRETS_KEY_VALUE_1', 'aws-secrets-key-value-1-development'),
      type: AwsSecretsManager::Config::KEY_VALUE
    },
    {
      name: ENV.fetch('AWS_SECRETS_KEY_VALUE_2', 'aws-secrets-key-value-2-development'),
      type: AwsSecretsManager::Config::KEY_VALUE
    },
  ]
)
```

In complex environments where applications require the use of multiple secrets, this game can be an interesting solution.

In AWS Secrets Manager if you have secret with name example-1 and with Secret value type => Key/value:

```ruby
{
  "ex_1":"1",
  "ex_2":"2",
  "ex_3":"3"
}
```
in console when type ENV you will have 3 env variable like:

```ruby
{
  "EX_1"=>"1",
  "EX_1"=>"1",
  "EX_1"=>"1"
}
```

In AWS Secrets Manager if you have secret with name example-2 and with Secret value type => Plaintext with value: 123456789

in console when type ENV you will have 1 env variable like:

```ruby
{
  "EXAMPLE_2"=>"123456789"
}
```

IMPORTANT!!! When type => Plaintext

SECRET NAME IS ENV KEY AND Secret value IS ENV VALUE

Full example:

Config:

```ruby
# frozen_string_literal: true

require 'aws_secrets_manager'

AwsSecretsManager.configure do |config|
  config.aws_region = ENV.fetch('AWS_REGION', 'eu-west-1')
end

AwsSecretsManager.get_secret_value(
  secrets: [
    {
      name: 'common-secrets',
      type: AwsSecretsManager::Config::KEY_VALUE
    },
    {
      name: 'fake-ssh-key',
      type: AwsSecretsManager::Config::PLAINTEXT
    },
  ]
)
```
Console output:

```ruby
{
  "DATABASE_DSN"=>"postgres://user:pass@server:5432/db",
  "API_KEY"=>"5S6BX2c6vx879eZ",
  "ORIGIN"=>"https://example.com"
  "SMTP_HOST"=>"mailcluster.example.com",
  "FAKE_SSH_KEY"=>"-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCxxx7OfuLEm3wm\njOVKL4+ibYBrrL3p8id2x4DZ3C+7C8ZkwsC6\n"
}

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/alekpopovic/aws-secrets-manager. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/alekpopovic/aws-secrets-manager/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the aws-secrets-manager project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/alekpopovic/aws-secrets-manager/blob/main/CODE_OF_CONDUCT.md).
