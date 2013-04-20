# CheckoutThingy

Checkout.

## Installation

Add this line to your application's Gemfile:

    gem 'checkout_thingy', :git => 'git@github.com:szalansky/checkout_thingy.git'

And then execute:

    $ bundle

## Money

Using Float (especially Float#round!) to represent money is not the best idea. On branch **money** you can find **checkout_thingy** that uses **money** gem (which is go-to money library for Ruby).

So write this in your Gemfile:

    gem 'checkout_thingy', :git => 'git@github.com:szalansky/checkout_thingy.git', :branch => 'money'

And then:

	$ bundle
