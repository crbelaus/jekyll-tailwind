# frozen_string_literal: true

require_relative "jekyll-tailwind/version"

require "jekyll"
require "open3"

module Jekyll
  class Tailwind
  end
end

Jekyll::Hooks.register [:site], :post_write do |site|
  tailwind_path = File.expand_path("_tailwind/tailwindcss", site.source)
  postcss_command = `#{tailwind_path} -i _site/assets/css/app.css -o _site/assets/css/app.css -c _tailwind/tailwind.config.js`

  Jekyll.logger.info "Tailwind:", "CSS rebuilt"
end
