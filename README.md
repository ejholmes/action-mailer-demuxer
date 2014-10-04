# ActionMailer Demuxer

A ruby gem for demuxing ActionMailer delivery methods.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'action-mailer-demuxer'
```

And then execute:

```console
$ bundle
```

Or install it yourself as:

```console
$ gem install action-mailer-demuxer
```

## Usage

Configure the action mailer delivery method

```ruby
config.action_mailer.delivery_method = :demuxer
config.action_mailer.demuxer_settings = { email: :smtp, sms: :letter_opener }
```

Flag your mailer classes with a `type` default:

```ruby
class Emailer < ActionMailer::Base
  default type: :email
end

class Texter < ActionMailer::Base
  default type: :sms
end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
