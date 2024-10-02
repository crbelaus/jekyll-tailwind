# Jekyll::Tailwind

**This gem allows you integrate the [TailwindCSS Standalone CLI](https://tailwindcss.com/blog/standalone-cli) in your Jekyll site.** The Tailwind CLI is a standalone executable that doesn't need NodeJS or any other external dependency.

## Set up

To add this gem to your project you must include it in your Gemfile:

1. Add a gem
```ruby
group :jekyll_plugins do
  gem 'jekyll-tailwind'
end
```
2. Add plugin to _config.yml:
```yml
plugins:
  - jekyll-tailwind
```

3. Add **tailwind.config.js** to root directory with following contents
```js
module.exports = {
  content: ["./**/*.html"],
  theme: {
    extend: {},
  },
  plugins: [
    require('@tailwindcss/typography'),
    require('@tailwindcss/forms'),
    require('@tailwindcss/container-queries')
  ],
};
```

4. Modify default template to include app.css, e.g.:
`<link rel="stylesheet" href="{{ "/assets/css/app.css" | relative_url }}">`


## Adjust tailwind configuration

By default Tailwind will:
- read the `tailwind.config.js` file that lives in your project's root (more info at [the Tailwind docs](https://tailwindcss.com/docs/configuration)).
- Output file will also be written into `_site/assets/css/app.css`.
- Process postcss if `postcss.config.js` is present in the root directory.

But it's possible to tweak these settings through `_config.yml` file:

```yml
tailwind:
  config: config/tailwind.config.js
  input: assets/css/app.css # or [assets/css/app.css, assets/css/web.css]
  output: _site/assets/css/web.css
  postcss: config/postcss.config.js # default is nil
  minify: true # defaults to false
```

## Picking Tailwind version
It's possible to pick particular version of tailwindd by locking `tailwindcss-ruby` dependency to certain version. Add following to your Gemfile:

`gem 'tailwindcss-ruby', '>=3', '<4'`

or if you're looking for a 4v:

`gem 'tailwindcss-ruby', '>=4'`


## Troubleshooting
You may run into issues with tailwind executable, please refer to [troubleshooting section in tailwindcss-ruby gem](https://github.com/flavorjones/tailwindcss-ruby?tab=readme-ov-file#troubleshooting).
