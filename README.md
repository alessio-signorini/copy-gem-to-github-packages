# Copy Gem to Github Packages Action

![.github/workflows/test.yml](https://github.com/alessio-signorini/copy-gem-to-github-packages-action/workflows/.github/workflows/test.yml/badge.svg)

This action copies a Gem from any repository (even if they required
authentication) into the Github Packages repository of your organization.

This can be useful to make availabe a private/protected gem
(e.g., `sidekiq-pro` or `sidekiq-ent`) to the entire organization without
having to include the credentials in the Gemfile, or to create and
keep updated a private repository of known/verified gems.

## Inputs
  * `gem_name` - The name of the gem to copy [**required**]
  * `gem_repository` - The URL of the repository (default `https://rubygems.org`)

## Output
The gem will be copied in the packages of the organization's repository
where this action is ran.

## ENVs
Until Github sets the `GITHUB_TOKEN` automatically it is necessary to
manually specify it in the configuration below as
```yaml
  env:
     GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```

## Single Step
This is the minimum code necessary for a single `step` to copy the
`httparty` gem from the standard RubyGems repository into Github packages
associated to the current git repository in your organization.
```yaml
uses: alessio-signorini/copy-gem-to-github-packages@v2
env:
  GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
with:
  gem_name: 'httparty'
```

## Advanced usage
This action will run every day at midnight and will copy the `sidekiq-ent`
package from the private/protected repository into your organization.
The basic auth credentials used to access the private repository are saved
as secrets.
```yaml
on:
  schedule:
    - cron:  '0 0 * * *'    # Run every day at midnight

jobs:
  refresh:
    runs-on: ubuntu-latest
    name: Refresh Packages
    steps:
      - name: sidekiq-ent
        uses: alessio-signorini/copy-gem-to-github-packages@v2
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
        with:
          gem_name: 'sidekiq-ent'
          gem_repository: 'https://${{ secrets.SIDEKIQ_AUTH }}@enterprise.contribsys.com'
```