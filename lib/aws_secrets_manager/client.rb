module AwsSecretsManager
  module Client
    def client
      Aws::SecretsManager::Client.new(
        region: AwsSecretsManager.config.aws_region
      )
    rescue Errors::InvalidRegionError, Aws::Errors::InvalidRegionError
      raise Errors.aws_region_error
    end
  end
end
