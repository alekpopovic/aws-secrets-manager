# frozen_string_literal: true

module AwsSecretsManager
  module Config
    class << self
      def included(base)
        base.extend(ClassMethods)
      end
    end

    module ClassMethods
      def config
        @config ||= Configuration.new
      end

      def configure
        yield config
      end
    end

    class Configuration
      attr_accessor :aws_region
    end

    specs = {
      plaintext: "plaintext",
      key_value: "key_value",
    }

    specs.each { |k, v| const_set(k.upcase, v) }
  end
end
