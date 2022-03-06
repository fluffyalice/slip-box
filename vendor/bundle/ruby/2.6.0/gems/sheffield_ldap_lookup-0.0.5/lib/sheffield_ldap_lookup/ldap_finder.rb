require 'net/ldap'
module SheffieldLdapLookup
  class LdapFinder
    attr_accessor :keyword
    attr_accessor :custom_search_attribute

    def initialize(keyword = nil, config_prefix = nil, custom_search_attribute = nil)
      self.keyword   = keyword
      @config_prefix = config_prefix
      self.custom_search_attribute = custom_search_attribute
    end

    class << self
      attr_accessor :ldap_config
    end

    def lookup
      begin
        @lookup ||= connection.search(filter: ldap_filter)[0]
      rescue
        {}
      end
    end

    def ldap_filter(filter_class = Net::LDAP::Filter)
      filter_class.eq(search_attribute, keyword)
    end

    def search_attribute
      return custom_search_attribute if custom_search_attribute
      keyword =~ /\A[^@]+@[^@]+\z/ ? 'mail' : 'uid'
    end

    def ldap_config
      self.class.ldap_config
    end

    def connection(ldap_class = Net::LDAP)
      @connection ||= ldap_class.new(connection_settings)
    end

    def connection_settings
      base_settings = {
        host: ldap_config["#{@config_prefix}host"], port: ldap_config["#{@config_prefix}port"], base: ldap_config["#{@config_prefix}base"]
      }

      if ldap_config.key?("#{@config_prefix}username") && ldap_config.key?("#{@config_prefix}password")
        base_settings[:auth] = {
          method: :simple,
          username: ldap_config["#{@config_prefix}username"],
          password: ldap_config["#{@config_prefix}password"]
        }
      end
      base_settings
    end

  end
end