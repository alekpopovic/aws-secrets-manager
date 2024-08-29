# frozen_string_literal: true

require "json"
require "zeitwerk"
require "aws-sdk-secretsmanager"
require "active_support/inflector"
require "dry-validation"

loader = Zeitwerk::Loader.for_gem
loader.setup

module AwsSecretsManager
  class Error < StandardError; end

  class Validator < Dry::Validation::Contract
    params do
      required(:secrets_configuration).array do
        schema do
          required(:type).filled(:string)
          required(:name).filled(:string)
        end
      end
    end
  end

  class Configuration
    attr_accessor :aws_region

    def initialize
      yield self if block_given?
    end

    def perform_secrets_initialization(secrets_configuration)
      v = Validator.new.call(secrets_configuration)

      raise Error.new(v.errors.to_h) if v.errors.any?

      secrets_configuration[:secrets_configuration].each do |secret|
        case secret[:type]
        when "plaintext"
          then handle_plaintext_secret(name: secret[:name])
        when "key_value"
          then handle_key_value_secret(name: secret[:name])
        else
          raise Error.new("Only plaintext && key_value secrets types is allowed!!!")
        end
      end
    end

    private

    def handle_plaintext_secret(**args)
      c = Aws::SecretsManager::Client.new(region: @aws_region)
      r = c.get_secret_value(secret_id: args[:name])
      j = JSON.generate({"#{r.name}": "#{r.secret_string}"})
      JSON.parse(j).each_pair do |k, v|
        ENV[k.to_s.underscore.upcase] = v
      end
    rescue Aws::SecretsManager::Errors::ResourceNotFoundException
      raise "AWS Secrets Manager Secret #{args[:name]} not exists!!!"
    end

    def handle_key_value_secret(**args)
      c = Aws::SecretsManager::Client.new(region: @aws_region)
      r = c.get_secret_value(secret_id: args[:name])
      JSON.parse(r.secret_string).each_pair do |k, v|
        ENV[k.to_s.underscore.upcase] = v
      end
    rescue Aws::SecretsManager::Errors::ResourceNotFoundException
      raise "AWS Secrets Manager Secret #{args[:name]} not exists!!!"
    end
  end
end
