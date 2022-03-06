# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sheffield_ldap_lookup/version'

Gem::Specification.new do |gem|
  gem.name          = "sheffield_ldap_lookup"
  gem.version       = SheffieldLdapLookup::VERSION
  gem.authors       = ["Shuo Chen"]
  gem.email         = ["s.chen@epigenesys.co.uk"]
  gem.description   = "A gem to fetch information from University of Sheffield LDAP server based on username or email address."
  gem.summary       = "LDAP lookup"
  gem.homepage      = "http://www.epigenesys.org.uk"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  
  gem.add_dependency('net-ldap')
  
  gem.add_development_dependency('rake')
  gem.add_development_dependency('rails', '>= 3.2')
  gem.add_development_dependency('rspec')
end