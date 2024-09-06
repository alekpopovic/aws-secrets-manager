# frozen_string_literal: true

if Gem.loaded_specs.key?("rails")
  require "rails/generators"

  module AwsSecretsManager
    module Generators
      class Install < Rails::Generators::Base
        # rubocop:disable Layout/HeredocIndentation
        def create_helper_file
          create_file("config/initializers/aws_secrets_manager.rb", <<-FILE)
# frozen_string_literal: true

require 'aws_secrets_manager'

AwsSecretsManager.configure do |config|
  config.aws_region = ENV.fetch("AWS_REGION", 'eu-west-1')
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
          FILE
        end
        # rubocop:enable Layout/HeredocIndentation
      end
    end
  end
end
