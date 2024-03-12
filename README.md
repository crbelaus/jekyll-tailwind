# Jekyll::Tailwind

This gem allows you to use [TailwindCSS Standalone CLI][tailwind-cli] in your Jekyll site. The CLI is a standalone executable that you can download and vendor in your project and does not require NodeJS or anything to run.

This is the first gem that I publish and it is in a very early stage. I consider it to be pretty stable (it has very little code and no external dependencies other than Jekyll itself) but it is not very customizable yet.

The gem expects that you have the following files in your Jekyll site:

- `_tailwind/tailwindcss`: your [Tailwind Standalone CLI][tailwind-cli] executable.
- `_tailwind/tailwind.config.js`: your Tailwind configuration.
- `_site/assets/css/app.css`: your CSS file.

With this in place, the gem works automatically. After you site is built it will update your CSS file.

[tailwind-cli]: https://tailwindcss.com/blog/standalone-cli
