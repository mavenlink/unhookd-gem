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
Unhookd can be configured and used in a Ruby Script for one off deploys. Here is an example:

```ruby
#!/usr/bin/env ruby

require "unhookd"

sha = ARGV[1]
compare_url = ARGV[2]

Unhookd.configure do |config|
  config.unhookd_url = "your-unhookd-url"
  config.chart_name = "your-repo/your-chart"
end

Unhookd.deploy!("release-name", { "your" => { "values" => "to-override}" } })
```

By default, release-name serves as both the namespace the app will be deployed in and the name of the Helm release 

Even better, pair this with a job in Circle Ci to enable continuous deploys to your Kubernetes cluster!

## Configuration
| Name                  | Required | Description                                                                                                               |
|-----------------------|----------|---------------------------------------------------------------------------------------------------------------------------|
| unhookd_url           | yes      | Url that Unhookd exposes in your cluster                                                                                  |
| chart_name            | yes      | The charts repository and name for Unhookd to deploy e.g. repo/chart                                                      |
| values_file_path      | no       | Path to a base values file where default values can be specified.                                                         |
| namespace             | no       | A namespace to be installed in. If not specified, the value of the release name will be used.                             |
| slack_webhook_url     | no       | A Slack Webhook URl to send a post-deploy notification to                                                                 |
| slack_webhook_message | no       | A Slack Webhook Message to send with the post-deploy notification. Valid keys are: :header, :title, :title_link, :message |

## Configuring Slack Notifications

Unhookd can optionally notify a slack channel when a deploy has been triggered. Here is an example of a slack notification configuration:

```ruby
Unhookd.configure do |config|
  config.slack_webhook_url = 'some-url'
  config.slack_webhook_message = {
    header: "The `staging` branch of `my-rails-app` was deployed to `my-kubernetes-cluster`",
    title: "This field will be linked to whatever the title_link is",
    title_link: "https://some-url.com",
    text: "A larger text field for adding more information about your deploy.",
  }
end
```

To get a webhook url for Slack, you can visit the [Custom Integrations](https://mavenlink.slack.com/apps/manage/custom-integrations) page. From there select "Incoming Webhooks" and click the `Add Configuration` button. There you can choose a channel and receive a webhook url.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/unhookd. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Unhookd project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/unhookd/blob/master/CODE_OF_CONDUCT.md).
