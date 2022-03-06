module SheffieldLdapLookup
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path("../templates", __FILE__)
    
    def create_initializer
      copy_file "sheffield_ldap_lookup.rb", "config/initializers/sheffield_ldap_lookup.rb"
    end
  end
end