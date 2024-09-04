module AwsSecretsManager
  module GetSecretValue
    include Plaintext
    include KeyValue

    def get_secret_value(secrets)
      validator = Validator::Validate.new.call(secrets)

      raise AwsSecretsManager::Error.new(validator.errors.to_h) if validator.errors.any?

      secrets[:secrets].each do |secret|
        case secret[:type]
        when AwsSecretsManager::Config::PLAINTEXT
          then plaintext(name: secret[:name])
        when AwsSecretsManager::Config::KEY_VALUE
          then key_value(name: secret[:name])
        else
          raise AwsSecretsManager::Error.new("Only plaintext && key_value secrets types is allowed!!!")
        end
      end
    end
  end
end
