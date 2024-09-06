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
          FILE
        end
        # rubocop:enable Layout/HeredocIndentation
      end
    end
  end
end
