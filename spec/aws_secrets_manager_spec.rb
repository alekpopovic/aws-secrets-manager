# frozen_string_literal: true

RSpec.describe(AwsSecretsManager) do
  it "has a version number" do
    expect(AwsSecretsManager::VERSION).not_to(be(nil))
  end
end
