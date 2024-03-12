# frozen_string_literal: true

require_relative "jekyll-tailwind/version"
require_relative "jekyll-tailwind/installer"

require "jekyll"
require "open3"

Jekyll::Hooks.register [:site], :post_write do |site|
  Jekyll::Tailwind::Installer.install_and_run

  Jekyll.logger.info "Tailwind:", "CSS rebuilt"
end
