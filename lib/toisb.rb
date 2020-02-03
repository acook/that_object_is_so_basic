require_relative "toisb/wrapper"

module TOISB
  def self.wrap object, trace = nil
    Wrapper.new object, (trace || caller)
  end
end
