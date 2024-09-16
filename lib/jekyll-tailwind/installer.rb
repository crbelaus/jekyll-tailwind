# frozen_string_literal: true

require "fileutils"
require "jekyll"
require "open-uri"

module Jekyll
  class Tailwind::Installer
    def initialize(options)
      @target =
        case RUBY_PLATFORM
        when "arm64-darwin23"
          "macos-arm64"
        when "x86_64-darwin"
          "macos-x64"
        when "x86_64-linux"
          "linux-x64"
        else
          raise "Tailwind CLI is not available for platform: #{RUBY_PLATFORM}"
        end

      @version = options[:version] || "3.4.1"
      @config_path = options[:config_path] || "tailwind.config.js"
      @path = "_tailwind/tailwind-#{@target}-#{@version}"
    end

    def install_and_run
      install unless File.exist?(@path)

      `#{@path} -i _site/assets/css/app.css -o _site/assets/css/app.css -c #{@config_path}`
      Jekyll.logger.info "Tailwind:", "Rebuilt _site/assets/css/app.css"
    end

    private

    def install
      Jekyll.logger.info "Tailwind:", "CLI version #{@version} not found for #{@target}"
      Jekyll.logger.info "Tailwind:", "Installing..."

      uri = URI.parse("https://github.com/tailwindlabs/tailwindcss/releases/download/v#{@version}/tailwindcss-#{@target}")
      file = uri.open

      FileUtils.mkdir "_tailwind" unless File.exist?("_tailwind")
      FileUtils.install file.path, @path, mode: 0o755

      Jekyll.logger.info "Tailwind:", "CLI installed at #{@path}"
    end
  end
end
