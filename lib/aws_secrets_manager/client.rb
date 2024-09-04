module AwsSecretsManager
  module Client
    def client
      Aws::SecretsManager::Client.new(region: AwsSecretsManager.config.aws_region)
    rescue Aws::Errors::InvalidRegionError => error
      raise AwsSecretsManager::Error.new(error)
    end
  end
end
