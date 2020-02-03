require_relative "uspec_helper"

class ::TestObject < BasicObject; end
obj = ::TestObject.new

spec "can skip trace arg and @trace will still be set" do
  toisb = TOISB.wrap obj
  actual = toisb.instance_variable_get :@trace
  actual.is_a?(Array) || actual
end

spec "can pass nil as trace and @trace will still be set" do
  arg = nil
  toisb = TOISB.wrap obj, arg
  actual = toisb.instance_variable_get :@trace
  actual.is_a?(Array) || actual
end

spec "other values passed as trace and @trace will equal it" do
  expected = "foo"
  toisb = TOISB.wrap obj, arg
  actual = toisb.instance_variable_get :@trace
  (actual == expected) || actual
end
