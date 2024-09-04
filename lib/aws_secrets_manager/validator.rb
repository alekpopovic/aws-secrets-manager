# frozen_string_literal: true

module AwsSecretsManager
  module Validator
    class Validate < Dry::Validation::Contract
      params do
        required(:secrets).array do
          schema do
            required(:type).filled(:string)
            required(:name).filled(:string)
          end
        end
      end
    end
  end
end
