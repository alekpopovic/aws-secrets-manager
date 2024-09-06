# frozen_string_literal: true

module AwsSecretsManager
  module Client
    def client
      Aws::SecretsManager::Client.new(
        region: AwsSecretsManager.config.aws_region,
      )
    end
  end
end
