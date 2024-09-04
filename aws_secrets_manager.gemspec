# frozen_string_literal: true

require_relative "lib/aws_secrets_manager/version"

Gem::Specification.new do |spec|
  spec.name = "aws-secrets-manager"
  spec.version = AwsSecretsManager::VERSION
  spec.authors = ["Aleksandar Popovic"]
  spec.email = ["aleksandar.popovic@linux.com"]

  spec.summary = "Aws Secrets Manager gem for Rails and all Rack apps"
  spec.description = "Support multiple plaintext and key-value aws secrets"
  spec.homepage = "https://github.com/alekpopovic/aws-secrets-manager"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/alekpopovic/aws-secrets-manager"
  spec.metadata["changelog_uri"] = "https://github.com/alekpopovic/aws-secrets-manager/blob/main/CHANGELOG.md"

  gemspec = File.basename(__FILE__)

  spec.files = IO.popen(["git", "ls-files", "-z"], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?("bin/", "test/", "spec/", "features/", ".git", ".github", ".vscode", "appveyor", "Gemfile")
    end
  end

  spec.require_paths = ["lib"]

  spec.add_dependency("activesupport")
  spec.add_dependency("aws-sdk-secretsmanager")
  spec.add_dependency("dry-validation")
  spec.add_dependency("zeitwerk")
end
