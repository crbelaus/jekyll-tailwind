# frozen_string_literal: true

require "fileutils"
require "open-uri"

module Jekyll
  class Tailwind::Installer
    def self.install
      uri = URI.parse("https://github.com/tailwindlabs/tailwindcss/releases/download/v3.4.1/tailwindcss-#{target}")
      file = uri.open

      FileUtils.move file.path, cli_path
      FileUtils.chmod 0o755, cli_path
    end

    def self.cli_path
      target = self.target

      "_tailwind/tailwind-#{target}"
    end

    def self.target
      case RUBY_PLATFORM
      when "arm64-darwin23"
        "macos-arm64"
      when "x86_64-linux"
        "linux-x64"
      else
        raise "Tailwind CLI is not available for platform: #{RUBY_PLATFORM}"
      end
    end

    def self.install_and_run
      unless File.exist?(cli_path)
        install
      end

      `#{cli_path} -i _site/assets/css/app.css -o _site/assets/css/app.css -c _tailwind/tailwind.config.js`
    end
  end
end
