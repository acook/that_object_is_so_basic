module TOISB; class Wrapper
  def initialize object, trace = nil
    @object = object
    @trace = trace || caller
  end
  attr_reader :object, :trace

  # Checks for an inspect method and falls back to Superclass/Class:ID
  def inspector
    inspector!
  rescue
    simple_inspector
  end

  # This version doesn't rescue when #inspect raises
  def inspector!
    klass && klass.public_method_defined?(:inspect) ? object.inspect : simple_inspector
  end

  # Simple inspect-ish output with a low chance of failure
  def simple_inspector
    "#<#{klassinfo}:0x#{get_id}>"
  end

  # show a nicely formated version of the class and its superclass
  # displays it in the style of a path, with the superclass as the parent directory
  def klassinfo
    [superklass, klass].compact.map(&:name).join "/"
  end

  # show a nicely formated version of the class and its superclass
  # displays it in the same style as the class definition
  def subklassinfo
    [klass, superklass].compact.join " < "
  end

  # Obtain the singleton class of an object
  def singleton
    @singleton ||= (class << object; self; end) rescue object.class
  end

  # Collects the ancestors of an object
  def ancestors
    @ancestors ||= singleton.ancestors
  end

  # Collects only the ancestors which are Classes and not Modules or singleton classes
  def ancestor_klasses
    @ancestor_klasses ||= ancestors.select {|a| Class === a && !a.singleton_class? }
  end

  # Returns the class of the object
  def klass
    @klass ||= ancestor_klasses[0]
  end

  # Returns the superclass of the object
  def superklass
    @superklass ||= ancestor_klasses[1]
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
    raise NotImplementedError, "Bind functionality wasn't added until Ruby 2.0." if ::RUBY_VERSION < "2.0.0"
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
