# frozen_string_literal: true

require_relative "lib/smarty_address/version"

Gem::Specification.new do |spec|
  spec.name = "smarty_address"
  spec.version = SmartyAddress::VERSION
  spec.authors = ["Lyric"]
  spec.email = ["he-him@lyric.dev"]

  spec.summary = "Validate and format addresses via Smarty"
  spec.homepage = "https://lyric.dev"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://lyric.dev"
  spec.metadata["changelog_uri"] = "https://lyric.dev"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.executables << "smarty_address"
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  spec.add_dependency "dotenv-rails", "~> 2.8.1"
  spec.add_dependency "optparse", "~> 0.3.1"
  spec.add_dependency "smartystreets_ruby_sdk", "~> 5.14.19"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
  spec.metadata["rubygems_mfa_required"] = "true"
end
