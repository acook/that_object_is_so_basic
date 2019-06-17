require_relative "uspec_helper"

spec "existance" do
  defined?(TOISB) == "constant"
end

spec "can wrap BasicObjects" do
  toisb = TOISB.wrap BasicObject.new
  !!toisb
end
