# frozen_string_literal: true

require_relative "lib/jekyll-tailwind/version"

Gem::Specification.new do |spec|
  spec.name = "jekyll-tailwind"
  spec.version = Jekyll::Tailwind::VERSION
  spec.authors = ["Cristian Álvarez Belaustegui", "Stanislav (Stas) Katkov"]
  spec.email = ["cristian@crbelaus.com", "github@skatkov.com"]

  spec.summary = "Use Tailwind CLI from your Jekyll site"
  spec.description = "Run TailwindCSS from your Jekyll site without requiring NodeJS"
  spec.homepage = "https://github.com/crbelaus/jekyll-tailwind"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/crbelaus/jekyll-tailwind"
  spec.metadata["changelog_uri"] = "https://github.com/crbelaus/jekyll-tailwind/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "jekyll", ">= 3.0", "< 5.0"
  spec.add_dependency "tailwindcss-ruby"
  # Let's use it to publish to rubygems (e.g. rake release)
  spec.add_development_dependency "rake"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
