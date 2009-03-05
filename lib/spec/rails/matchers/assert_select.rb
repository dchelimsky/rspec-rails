# This is a wrapper of assert_select for rspec.

module Spec # :nodoc:
  module Rails
    module Matchers

      class AssertSelect #:nodoc:
        
        def initialize(assertion, spec_scope, *args, &block)
          @assertion = assertion
          @spec_scope = spec_scope
          @args = args
          @block = block
        end
        
        def matches?(response_or_text, &block)
          @block = block if block

          if doc = doc_from(response_or_text)
            @args.unshift(doc)
          end

          begin
            @spec_scope.__send__(@assertion, *@args, &@block)
            true
          rescue ::Test::Unit::AssertionFailedError => @error
            false
          end
        end
        
        def failure_message_for_should; @error.message; end
        def failure_message_for_should_not; "should not #{description}, but did"; end

        def description
          {
            :assert_select => "have tag#{format_args(*@args)}",
            :assert_select_email => "send email#{format_args(*@args)}",
          }[@assertion]
        end

      private

        module TestResponseOrString
          def test_response?
            ActionController::TestResponse === self and
                                               !self.headers['Content-Type'].blank? and
                                               self.headers['Content-Type'].to_sym == :xml
          end
        
          def string?
            String === self
          end
        end

        def doc_from(response_or_text)
          response_or_text.extend TestResponseOrString
          markup = response_or_text.body if response_or_text.test_response?
          markup = response_or_text if response_or_text.string?
          HTML::Document.new(markup, false, true).root if markup
        end
        
        def format_args(*args)
          args.empty? ? "" : "(#{arg_list(*args)})"
        end

        def arg_list(*args)
          args.map do |arg|
            arg.respond_to?(:description) ? arg.description : arg.inspect
          end.join(", ")
        end
        
      end
      
      # :call-seq:
      #   response.should have_tag(*args, &block)
      #   string.should have_tag(*args, &block)
      #
      # wrapper for assert_select with additional support for using
      # css selectors to set expectation on Strings. Use this in
      # helper specs, for example, to set expectations on the results
      # of helper methods.
      #
      # == Examples
      #
      #   # in a controller spec
      #   response.should have_tag("div", "some text")
      #
      #   # in a helper spec (person_address_tag is a method in the helper)
      #   person_address_tag.should have_tag("input#person_address")
      #
      # see documentation for assert_select at http://api.rubyonrails.org/
      def have_tag(*args, &block)
        @__current_scope_for_assert_select = AssertSelect.new(:assert_select, self, *args, &block)
      end
    
      # wrapper for a nested assert_select
      #
      #   response.should have_tag("div#form") do
      #     with_tag("input#person_name[name=?]", "person[name]")
      #   end
      #
      # see documentation for assert_select at http://api.rubyonrails.org/
      def with_tag(*args, &block)
        @__current_scope_for_assert_select.should have_tag(*args, &block)
      end
    
      # wrapper for a nested assert_select with false
      #
      #   response.should have_tag("div#1") do
      #     without_tag("span", "some text that shouldn't be there")
      #   end
      #
      # see documentation for assert_select at http://api.rubyonrails.org/
      def without_tag(*args, &block)
        @__current_scope_for_assert_select.should_not have_tag(*args, &block)
      end
    
      # :call-seq:
      #   response.should have_rjs(*args, &block)
      #
      # wrapper for assert_select_rjs
      #
      # see documentation for assert_select_rjs at http://api.rubyonrails.org/
      def have_rjs(*args, &block)
        AssertSelect.new(:assert_select_rjs, self, *args, &block)
      end
      
      # :call-seq:
      #   response.should send_email(*args, &block)
      #
      # wrapper for assert_select_email
      #
      # see documentation for assert_select_email at http://api.rubyonrails.org/
      def send_email(*args, &block)
        AssertSelect.new(:assert_select_email, self, *args, &block)
      end
      
      # wrapper for assert_select_encoded
      #
      # see documentation for assert_select_encoded at http://api.rubyonrails.org/
      def with_encoded(*args, &block)
        should AssertSelect.new(:assert_select_encoded, self, *args, &block)
      end
    end
  end
end
