# frozen_string_literal: true

# require_relative "jekyll-tailwind/version"
require_relative "jekyll-tailwind/installer"

require "jekyll"
require "open3"

# module Jekyll
#   class Tailwind
#     def install(target)
#       # TODO configure the version
#       version = "3.4.1"
#       url = URI"https://github.com/tailwindlabs/tailwindcss/releases/download/v#{version}/tailwindcss-#{target}"


#     end
#   end
# end

Jekyll::Hooks.register [:site], :post_write do |site|
  Jekyll::Tailwind::Installer.install_and_run

  Jekyll.logger.info "Tailwind:", "CSS rebuilt"
end
