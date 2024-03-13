# frozen_string_literal: true

require_relative "jekyll-tailwind/version"
require_relative "jekyll-tailwind/installer"

require "jekyll"

Jekyll::Hooks.register [:site], :post_write do |site|
  tailwind = Jekyll::Tailwind::Installer.new(
    version: site.config.dig("tailwind", "version"),
    config_path: site.config.dig("tailwind", "config_path")
  )
  tailwind.install_and_run()
end
