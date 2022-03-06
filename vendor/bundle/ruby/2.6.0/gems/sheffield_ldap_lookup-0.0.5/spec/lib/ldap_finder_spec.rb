require 'spec_helper'
require 'sheffield_ldap_lookup/ldap_finder.rb'

describe SheffieldLdapLookup::LdapFinder do
  LDAP_CONFIG = { 'host' => 'localhost', 'port' => '389', 'base' => 'ou=Users' }
  describe "#connection" do
    it "should create a new LDAP connection" do
      subject.stub(ldap_config: LDAP_CONFIG)
      ldap_class = double
      ldap_class.should_receive(:new).with(host: LDAP_CONFIG['host'], port: LDAP_CONFIG['port'], base: LDAP_CONFIG['base'])
      subject.connection(ldap_class)
    end
  end
  
  describe "#ldap_config" do
    it "should load the LDAP configuration" do
      SheffieldLdapLookup::LdapFinder.ldap_config = LDAP_CONFIG
      subject.ldap_config.should == LDAP_CONFIG
    end
  end
  
  describe "#search_attribute" do
    describe "determine to search against uid or email based on the format of the keyword" do
      it "should use 'uid' attribute for username" do
        finder = SheffieldLdapLookup::LdapFinder.new('username')
        finder.search_attribute.should == 'uid'
      end
      
      it "should use 'mail' attribute for email" do
        finder = SheffieldLdapLookup::LdapFinder.new('test@test.com')
        finder.search_attribute.should == 'mail'
      end
    end
  end
  
  describe "#ldap_filter" do
    it "should create a LDAP filter for the attribute and keyword" do
      finder = SheffieldLdapLookup::LdapFinder.new('username')
      finder.stub(search_attribute: 'uid')
      filter_class = double
      filter_class.should_receive(:eq).with('uid', 'username')
      finder.ldap_filter filter_class
    end
  end
  
  describe "#lookup" do
    describe "use the LDAP filter to search for the entity and return the first result" do
      let(:ldap_filter) { double }
      let(:connection)  { double }
      before { subject.stub(ldap_filter: ldap_filter, connection: connection) }
      
      it "should search the LDAP connection using the filter" do
        connection.should_receive(:search).with(filter: ldap_filter).and_return([])
        subject.lookup
      end
      
      it "should return the first result" do
        result = double
        connection.stub(search: [result])
        subject.lookup.should == result
      end
      
      it "should return an empty hash if cannot connect to LDAP" do
        connection.stub(search: ->{raise})
        subject.lookup.should == {}
      end
    end
  end
end