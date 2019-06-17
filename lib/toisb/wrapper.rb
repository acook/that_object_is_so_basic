require_relative "helper"

module TOISB; class Wrapper
  include Helper

  def initialize object, trace = nil
    @object = object
    @trace = caller
  end
  attr_reader :object, :trace

  # Checks for an inspect method and falls back to Superclass/Class:ID
  def inspector
    fallback = "#<#{superklass}/#{klass}:0x#{get_id}>"
    klass && klass.public_method_defined?(:inspect) ? object.inspect : fallback
  rescue
    fallback
  end

  # Obtain the singleton class of an object
  def singleton
    @singleton ||= (class << object; self; end) rescue object.class
  end

  # Collects the ancestors of an object
  def ancestors
    @ancestors ||= safe_send_to singleton, :ancestors
  end

  # Collects only the ancestors which are Classes
  def ancestor_klasses
    @ancestor_klasses ||= ancestors.select {|a| Class === a }
  end

  # Returns the class of the object if it isn't already a class
  def klass
    @klass ||= Module === object ? object : ancestor_klasses[1]
  end

  # Returns the superclass of the object
  def superklass
    ancestor_klasses[2]
  end

  # Gets the object ID of an object
  def get_id
    @object_id ||= object.__id__.to_s(16) rescue 0
  end

  # Works around BasicObject and other objects that are missing/overwrite important methods
  def safe_send method, *args, &block
    safe_send_to object, method, *args, &block
  end

  # This is here so you can pass in an arbitrary object
  def safe_send_to target, method, *args, &block
    (Module === target ? Module : Object).instance_method(method).bind(target).call(*args, &block)
  end

  # Calling #inspect will call it recursively on contained objects
  # BasicObject does not define an #inspect instance method
  # So it will raise an error if the user hasn't defined one intentionally
  def inspect
    super
  rescue
    "#<#{self.class}:0x#{object_id} @object=#{inspector}>"
  end
end; end
