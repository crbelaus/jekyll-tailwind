# frozen_string_literal: true

require_relative "jekyll-tailwind/version"

require "jekyll"
require "tailwindcss/ruby"

module Jekyll
  class Tailwind

    def intialize(config)
      @config = config.fetch("config_path", "tailwind.config.js")
      @postcss = "postcss.config.js"
      @inputs = array_wrap(config["input"])
      @output = config.fetch("output", "_site/assets/css/app.css")
      @minify = config.fetch("minify", false)
    end

    def compile
      command = [
                Tailwindcss::Ruby.executable,
                "--output", @output,
                "--config", @config,
              ]

      @inputs.each do |input|
        # There could be multiple input files or non at all.
        command += ["--input", input]
      end

      command += ["--minify"] if @minify
      command += ["--postcss", @postcss] if File.exist?(@postcss)

      `#{command.join(' ')}`
    end

    private

    # Taken from rails/activesupport/lib/active_support/core_ext/array/wrap.rb
    def array_wrap(object)
      if object.nil?
        []
      elsif object.respond_to?(:to_ary)
        object.to_ary || [object]
      else
        [object]
      end
    end
  end
end

# It's important to run TailwindCSS compilation after Jekyll has finished with build steps. TailwindCSS will analyse resulting HTML and produce a CSS file with attributes that are actually in use, this is done to produce a smaller CSS file.
Jekyll::Hooks.register [:site], :post_write do |site|
  Jekyll::Tailwind.new(site.config.fetch('tailwind', {})).compile
end
