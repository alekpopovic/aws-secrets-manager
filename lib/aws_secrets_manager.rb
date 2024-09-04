# frozen_string_literal: true

require "json"
require "zeitwerk"
require "aws-sdk-secretsmanager"
require "active_support/inflector"
require "dry-validation"

loader = Zeitwerk::Loader.for_gem(warn_on_extra_files: false)
loader.setup

module AwsSecretsManager
  include Config
  extend Client
  extend GetSecretValue

  class Error < StandardError; end
end
