# frozen_string_literal: true

module AwsSecretsManager
  module Plaintext
    private

    def plaintext(**args)
      client = AwsSecretsManager.client

      response = client.get_secret_value(secret_id: args[:name])

      custom = JSON.generate(
        {
          "#{response.name}": "#{response.secret_string}"
        }
      )

      JSON.parse(custom).each_pair do |k, v|
        ENV[k.to_s.underscore.upcase] = v
      end
    rescue Aws::SecretsManager::Errors::ResourceNotFoundException
      raise Errors.secret_not_exists_error(args[:name])
    end
  end
end
