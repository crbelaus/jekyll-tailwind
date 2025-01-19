# frozen_string_literal: true

require_relative "jekyll-tailwind/version"

require "jekyll"
require "tailwindcss/ruby"

module Jekyll
  class Tailwind
    def initialize(config)
      if config["config_path"]
        Jekyll.logger.warn "WARNING: The `config_path` option is deprecated and will be removed in the next releases. Please use the `config` option instead."
      end
      if config["version"]
        Jekyll.logger.warn "WARNING: The `version` option has no effect, version could be managed through 'tailwindcss-ruby' gem in you're Gemfile."
      end

      @config = config["config_path"] || config["config"] || "tailwind.config.js"
      @postcss = config.fetch("postcss", "postcss.config.js")

      @input = if config["input"].is_a?(Array)
        Jekyll.logger.warn "DEPRECATION: jekyll-tailwind gem can't have multiple input files. Ability to provide array as input will be gradually fazed out. Change array value like this `[assets/css/app.css]` to `assets/css/app.css`"

        raise "Multiple input files are not supported" if config["input"].length > 1

        config["input"].first
      else
        config["input"]
      end
      @output = config.fetch("output", "_site/assets/css/app.css")
      @minify = config.fetch("minify", false)
    end

    def compile
      command = [
                Tailwindcss::Ruby.executable,
                "--output", @output,
                "--config", @config,
              ]

      command += ["--input", @input] if @input
      command += ["--minify"] if @minify
      command += ["--postcss", @postcss] if File.exist?(@postcss)

      `#{command.join(' ')}`
    end
  end
end

# It's important to run TailwindCSS compilation after Jekyll has finished with build steps. TailwindCSS will analyse resulting HTML and produce a CSS file with attributes that are actually in use, this is done to produce a smaller CSS file.
Jekyll::Hooks.register [:site], :post_write do |site|
  Jekyll::Tailwind.new(site.config.fetch('tailwind', {})).compile
end
