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
      raise AwsSecretsManager::Error.new("AWS Secrets Manager Secret #{args[:name]} not exists!!!")
    end
  end
end
