# unhookd-gem

This gem allows you to send a request to the Unhookd service in a Kubernetes cluster to deploy a rails application with a given sha and chart

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'unhookd'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install unhookd

## Usage
```
# Configure unhookd
Unhookd.configure do |config|
  config.unhookd_url = "your-url-to-your-unhookd-installation"
  config.chart_name = "your-chart-repo/your-chart-name"
  config.repo_name = "your-git-repository"
end

# Call deploy with the correct args!
Unhookd.deploy!("your-branch", "your-sha", { "some_value" => "you'd like to set on your chart" })
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/unhookd. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Unhookd project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/unhookd/blob/master/CODE_OF_CONDUCT.md).
