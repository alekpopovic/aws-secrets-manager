# frozen_string_literal: true

require_relative "lib/secops/version"

Gem::Specification.new do |spec|
  spec.name = "secops"
  spec.version = Secops::VERSION
  spec.authors = ["Aleksandar Popovic"]
  spec.email = ["aleksandar.popovic@linux.com"]

  spec.summary = "TODO: Write a short summary, because RubyGems requires one."
  spec.description = "TODO: Write a longer description or delete this line."
  spec.homepage = "https://github.com/alekpopovic/secops"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/alekpopovic/secops"
  spec.metadata["changelog_uri"] = "https://github.com/alekpopovic/secops"

  gemspec = File.basename(__FILE__)

  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile])
    end
  end

  spec.require_paths = ["lib"]

  spec.add_dependency "zeitwerk"
  spec.add_dependency "aws-sdk-secretsmanager"
  spec.add_dependency "activesupport"
  spec.add_dependency "dry-validation"
end
