That Object is So Basic!
========================

TOISB lets you play with BasicObject and other weird objects in Ruby in style and without breaking (as many) things.

[![Gem](https://img.shields.io/gem/v/that_object_is_so_basic.svg?style=for-the-badge)](https://rubygems.org/gems/that_object_is_so_basic)
[![GitHub Workflow Status (with event)](https://img.shields.io/github/actions/workflow/status/acook/that_object_is_so_basic/ruby.yml?style=for-the-badge)](https://github.com/acook/that_object_is_so_basic/actions)
[![Code Climate maintainability](https://img.shields.io/codeclimate/maintainability/acook/that_object_is_so_basic.svg?style=for-the-badge)](https://codeclimate.com/github/acook/that_object_is_so_basic)

Usage
-----

Install the gem like `gem install that_object_is_so_basic` then use it like this:

~~~ruby
require "toisb"

# TOISB was originally extracted from the Impasta and Uspec gems
class Impasta < BasicObject; end
spy = Impasta.new

# Wraps any BasicObject or subclass, including normal Objects
toisb = TOISB.wrap spy

toisb.klass #=> Impasta
toisb.superklass #=> BasicObject
tosib.inspector #=> "#<BasicObject/Impasta:0x2b1fcfc70474>"
toisb.singleton #=> #<Class:#<Impasta:0x0000563f9f8e08e8>>
toisb.ancestors #=> [#<Class:#<Impasta:0x0000563f9f8e08e8>>, Impasta, BasicObject]
toisb.safe_send :to_s #=> "#<TestObject:0x00005563c4965d48>"
~~~

Author
------

> © 2019-2024 Anthony M. Cook
