require_relative "uspec_helper"

class ::TestObject < BasicObject; end
obj = ::TestObject.new
toisb = TOISB.wrap obj

spec "can inspect BasicObject subclasses" do
  expected = "BasicObject/TestObject"
  actual = toisb.inspector
  actual.include?(expected) || actual
end

spec "can get the singleton class of a BasicObject subclass" do
  expected = "#<Class:#<TestObject"
  actual = toisb.singleton.to_s
  actual.include?(expected) || actual
end

# FIXME: Is it possible to get this to work on 2.0-2.2?
spec "can send common Object methods safely to a BasicObject subclass" do
  expected = "#<TestObject:"
  actual = toisb.safe_send :to_s
  actual.include?(expected) || actual
end unless RUBY_VERSION < "2.3.0"

spec "can get the class of a BasicObject" do
  expected = "TestObject"
  actual = toisb.klass.name
  actual.include?(expected) || actual
end

spec "can get the superclass of a BasicObject subclass" do
  expected = "BasicObject"
  actual = toisb.superklass.name
  actual.include?(expected) || actual
end

spec "can get the superclass (nil) of a BasicObject" do
  expected = nil
  actual = TOISB.wrap(BasicObject.new).superklass
  actual == expected || actual
end

spec "can get the ancestors of a BasicObject subclass" do
  expected = 3
  actual = toisb.ancestors
  actual.size == expected || actual
end

