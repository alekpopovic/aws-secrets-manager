module AwsSecretsManager
  module GetSecretValue
    include Plaintext
    include KeyValue

    def get_secret_value(secrets)
      validator = Validator::Validate.new.call(secrets)

      raise Errors.validation_error(validator.errors.to_h) if validator.errors.any?

      secrets[:secrets].each do |secret|
        case secret[:type]
        when Config::PLAINTEXT
          then plaintext(name: secret[:name])
        when Config::KEY_VALUE
          then key_value(name: secret[:name])
        else
          raise Errors.secret_type_error
        end
      end
    end
  end
end
