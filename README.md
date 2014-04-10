# WebLogin

WebLogin provides an easy-to-configure, architecture-agnistic web login form.

## Installation

Add this line to your application's Gemfile:

    gem 'web_login'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install web_login

## Usage

TODO: Write usage instructions here

To add alternate sign in buttons (say, for Facebook), create a partial
at `app/views/web_login/sessions/_alternate_sign_ins`.

## Todo:

At the moment, the place at which this utility is mounted is fixed by
the gem (currently at `/authentication`).  This is currently set by
two factors, the fact that `in config/routes.rb` references
`Rails.application` instead of `WebLogin::Engine`  and the
specification of the `:path`.

This is not ideal.  Ideally, host applications could set exactly where
they want this to be mounted.  However, because we need to reference
the absolute routes in helper functions that are installed in the host
application's controllers (see `lib/web_login/controller_helpers.rb`),
I couldn't figure out how to make those properly link to the right
routes.

So, for now, the path is locked, but the before_filters helpers work!

When someone with more router and more gem experience gets a wild
hair, they can make this change.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
