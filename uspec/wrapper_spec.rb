require_relative "uspec_helper"

class ::TestObject < BasicObject; end
obj = ::TestObject.new
toisb = TOISB.wrap obj

bowrap = TOISB.wrap BasicObject.new
arraywrap = TOISB.wrap(Array)
anonwrap = TOISB.wrap(Class.new Class.new)
modwrap = TOISB.wrap(Module.new)

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
  actual = bowrap.superklass
  actual == expected || actual
end

spec "can get the ancestors of a BasicObject subclass" do
  expected = 3
  actual = toisb.ancestors
  actual.size == expected || actual
end

spec "#inspector! doesn't mask exceptions if the associated inspect method fails" do
  class ::FailingInspectObject < BasicObject
     def inspect; ::Kernel.raise ::NotImplementedError, "This is supposed to fail"; end;
  end
  inspect_fail = TOISB.wrap ::FailingInspectObject.new

  begin
    inspect_fail.inspector!
  rescue NotImplementedError => error
    error.message.include?("supposed to fail") || error
  end
end

spec "generates correct klassinfo for BasicObject" do
  expected = "BasicObject"
  actual = bowrap.klassinfo
  actual == expected || actual
end

spec "generates correct subklassinfo for BasicObject" do
  expected = "BasicObject"
  actual = bowrap.subklassinfo
  actual == expected || actual
end

spec "generates correct klassinfo for BasicObject subclasses" do
  expected = "BasicObject/TestObject"
  actual = toisb.klassinfo
  actual == expected || actual
end

spec "generates correct subklassinfo for BasicObject subclasses" do
  expected = "TestObject < BasicObject"
  actual = toisb.subklassinfo
  actual == expected || actual
end

spec "generates correct klassinfo for classes like Array" do
  expected = "Module/Class"
  actual = arraywrap.klassinfo
  actual == expected || actual
end

spec "generates correct subklassinfo for classes like Array" do
  expected = "Class < Module"
  actual = arraywrap.subklassinfo
  actual == expected || actual
end

spec "generates correct klassinfo for anonymous classes" do
  expected = "Module/Class"
  actual = anonwrap.klassinfo
  actual == expected || actual
end

spec "generates correct subklassinfo for anonymous classes" do
  expected = "Class < Module"
  actual = anonwrap.subklassinfo
  actual == expected || actual
end

spec "generates correct klassinfo for anonymous modules" do
  expected = "Object/Module"
  actual = modwrap.klassinfo
  actual == expected || actual
end

spec "generates correct subklassinfo for anonymous modules" do
  expected = "Module < Object"
  actual = modwrap.subklassinfo
  actual == expected || actual
end
