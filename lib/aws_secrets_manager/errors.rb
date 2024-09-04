# frozen_string_literal: true

module AwsSecretsManager
  module Errors
    class << self
      class Error < StandardError; end

      def validation_error(error)
        Error.new(error)
      end

      def secret_type_error
        Error.new("Only #{Config::PLAINTEXT} && #{Config::KEY_VALUE} secrets types is allowed!!!")
      end

      def aws_region_error
        Error.new("Please provide aws_region value in configuration object")
      end

      def secret_not_exists_error(secret_name)
        Error.new("AWS Secrets Manager Secret #{secret_name} not exists!!!")
      end
    end
  end
end
