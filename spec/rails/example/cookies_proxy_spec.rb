require File.dirname(__FILE__) + '/../../spec_helper'

class CookiesProxyExamplesController < ActionController::Base
  def index
    cookies[:key] = cookies[:key]
  end
end

module Spec
  module Rails
    module Example
      describe CookiesProxy, :type => :controller do
        controller_name :cookies_proxy_examples
      
        describe "with a String key" do
        
          it "should accept a String value" do
            cookies = CookiesProxy.new(self)
            cookies['key'] = 'value'
            get :index
            cookies['key'].should == ['value']
          end
          
          if Rails::VERSION::STRING >= "2.0.0"
            it "should accept a Hash value" do
              cookies = CookiesProxy.new(self)
              cookies['key'] = { :value => 'value', :expires => expiration = 1.hour.from_now, :path => path = '/path' }
              get :index
              cookies['key'].should == ['value']
              cookies['key'].value.should == ['value']
              cookies['key'].expires.should == expiration
              cookies['key'].path.should == path
            end
          end
            
        end
      
        describe "with a Symbol key" do
        
          it "should accept a String value" do
            cookies = CookiesProxy.new(self)
            cookies[:key] = 'value'
            get :index
            cookies[:key].should == ['value']
          end

          if Rails::VERSION::STRING >= "2.0.0"
            it "should accept a Hash value" do
              cookies = CookiesProxy.new(self)
              cookies[:key] = { :value => 'value', :expires => expiration = 1.hour.from_now, :path => path = '/path' }
              get :index
              cookies[:key].should == ['value']
              cookies[:key].value.should == ['value']
              cookies[:key].expires.should == expiration
              cookies[:key].path.should == path
            end
          end

        end
    
      end
    
    end
  end
end
