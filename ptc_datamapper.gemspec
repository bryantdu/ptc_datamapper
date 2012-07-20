# -*- encoding: utf-8 -*-
require File.expand_path('../lib/ptc_datamapper/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Bryant"]
  gem.email         = ["bryant@promojam.com"]
  gem.description   = %q{This gem is to help you to map your csv file to a .txt file with specific format}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "ptc_datamapper"
  gem.require_paths = ["lib"]
  gem.version       = PtcDatamapper::VERSION

  gem.add_dependency "sqlite3"
  gem.add_dependency "activerecord"
  gem.add_dependency "csv-mapper"
end
