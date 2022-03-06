# -*- encoding: utf-8 -*-
# stub: sheffield_ldap_lookup 0.0.5 ruby lib

Gem::Specification.new do |s|
  s.name = "sheffield_ldap_lookup".freeze
  s.version = "0.0.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Shuo Chen".freeze]
  s.date = "2015-04-09"
  s.description = "A gem to fetch information from University of Sheffield LDAP server based on username or email address.".freeze
  s.email = ["s.chen@epigenesys.co.uk".freeze]
  s.homepage = "http://www.epigenesys.org.uk".freeze
  s.rubygems_version = "3.0.3".freeze
  s.summary = "LDAP lookup".freeze

  s.installed_by_version = "3.0.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<net-ldap>.freeze, [">= 0"])
      s.add_development_dependency(%q<rake>.freeze, [">= 0"])
      s.add_development_dependency(%q<rails>.freeze, [">= 3.2"])
      s.add_development_dependency(%q<rspec>.freeze, [">= 0"])
    else
      s.add_dependency(%q<net-ldap>.freeze, [">= 0"])
      s.add_dependency(%q<rake>.freeze, [">= 0"])
      s.add_dependency(%q<rails>.freeze, [">= 3.2"])
      s.add_dependency(%q<rspec>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<net-ldap>.freeze, [">= 0"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<rails>.freeze, [">= 3.2"])
    s.add_dependency(%q<rspec>.freeze, [">= 0"])
  end
end
