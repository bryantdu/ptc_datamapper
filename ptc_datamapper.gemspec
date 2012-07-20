# -*- encoding: utf-8 -*-
require File.expand_path('../lib/ptc_datamapper/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Bryant"]
  gem.email         = "bryant@promojam.com"
  gem.description   = "This gem is to help you to map your csv file to a .txt file with specific format"
  gem.summary       = "a simple gem"
  gem.homepage      = 'http://rubygems.org/gems/ptc_datamapper'

  gem.files         = ["lib/ptc_datamapper.rb"]
  gem.executables   << "ptc_datamapper"
  gem.name          = "ptc_datamapper"
  gem.version       = PtcDatamapper::VERSION

  gem.add_dependency "sqlite3"
  gem.add_dependency "activerecord"
  gem.add_dependency "csv-mapper"
end
