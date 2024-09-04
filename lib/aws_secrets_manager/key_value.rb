# frozen_string_literal: true

module AwsSecretsManager
  module KeyValue
    private

    def key_value(**args)
      client = AwsSecretsManager.client

      response = client.get_secret_value(secret_id: args[:name])

      JSON.parse(response.secret_string).each_pair do |k, v|
        ENV[k.to_s.underscore.upcase] = v
      end
    rescue Aws::SecretsManager::Errors::ResourceNotFoundException
      raise Errors.secret_not_exists_error(args[:name])
    end
  end
end
