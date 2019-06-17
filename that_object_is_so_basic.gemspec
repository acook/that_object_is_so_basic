Gem::Specification.new do |gem|
  gem.name        = "that_object_is_so_basic"
  gem.version     = "0.0.1"
  gem.summary     = "That Object is So Basic (TOISB) is a BasicObject handler."
  gem.description = "TOISB provides a wrapper class and a helper module for dealing with BasicObjects in style!"
  gem.authors     = ["Anthony M. Cook"]
  gem.email       = "github@anthonymcook.com"
  gem.files       = `git ls-files -z`.split(?\x0)
  gem.homepage    = "https://github.com/acook/that_object_is_so_basic"
  gem.license     = "Apache-2.0"

  gem.required_ruby_version = ">= 2.1"

  gem.add_development_dependency "uspec", "~> 0.2.1"

  gem.add_development_dependency "pry"
  gem.add_development_dependency "pry-doc"
end
