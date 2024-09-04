module AwsSecretsManager
  module Plaintext
    private

    def plaintext(**args)
      client = AwsSecretsManager.client

      response = client.get_secret_value(secret_id: args[:name])

      custom = JSON.generate({"#{response.name}": "#{response.secret_string}"})

      JSON.parse(custom).each_pair do |k, v|
        ENV[k.to_s.underscore.upcase] = v
      end
    rescue Aws::SecretsManager::Errors::ResourceNotFoundException
      raise AwsSecretsManager::Error.new("AWS Secrets Manager Secret #{args[:name]} not exists!!!")
    end
  end
end
