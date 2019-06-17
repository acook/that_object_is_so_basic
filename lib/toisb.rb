require_relative "toisb/wrapper"

module TOISB
  def self.wrap object
    Wrapper.new object, caller
  end
end
