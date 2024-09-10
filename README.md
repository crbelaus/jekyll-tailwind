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

2. Add **tailwind.config.js** to root directory with following contents
```js
module.exports = {
  content: ["./**/*.html", "./**/*.md"],
  theme: {
    extend: {},
  },
  plugins: [],
};
```

3. Add **assets/app.css** file with following contents
```css
@tailwind base;
@tailwind components;
@tailwind utilities;
```
4. Modify default template to include app.css, e.g.:
`<link rel="stylesheet" href="{{ "/assets/css/app.css" | relative_url }}">`

**The first time you build your Jekyll site, this gem will automatically download the Tailwind CLI for your platform and use it to build your CSS.** The Tailwind CLI will be saved in `_tailwind/tailwind-VERSION-PLATFORM`. It is recommended that you add this file to your `.gitignore` and don't commit it to your repository.

It is important to note that **subsequent runs will use the existing Tailwind CLI and won't download it again.**

## Customize the Tailwind version

Although not strictly necessary, it is recommended to pin your desired Tailwind CLI version in `_config.yml`.

```yml
tailwind:
  version: 3.4.1
```

If you don't do this, the gem will automatically download the latest Tailwind CLI version that was available when gem was published.

## Read the Tailwind configuration from an alternative path

By default Tailwind will read the `tailwind.config.js` file that lives in your project's root (more info at [the Tailwind docs](https://tailwindcss.com/docs/configuration)).

If your configuration file lives elsewhere you can say so in the `_config.yml` file:

```yml
tailwind:
  config_path: assets/tailwind.config.js
```
