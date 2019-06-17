That Object is So Basic!
========================

TOISB lets you play with BasicObject and other weird objects in Ruby in style and without breaking (as many) things.

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

> © 2019 Anthony M. Cook
