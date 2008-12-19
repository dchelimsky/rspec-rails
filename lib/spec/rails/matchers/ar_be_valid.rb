module Spec
  module Rails
    module Matchers
    
      class ArBeValid  #:nodoc:
        
        def initialize
          @matcher = Spec::Matchers::Be.new :be_valid
          @matcher.send :handling_predicate!
        end

        def matches?(actual)
          @actual = actual
          if @actual.respond_to?(:errors)
            @actual.valid?
          else
            @using_be_matcher = true
            @matcher.matches? @actual
          end
        end
      
        def failure_message
          if @using_be_matcher
            @matcher.failure_message
          else
            "Expected #{@actual.inspect} to be valid, but it was not\nErrors: " + @actual.errors.full_messages.join(", ")
          end
        end
        
        def negative_failure_message
          @matcher.negative_failure_message
        end
        
      end

      # :call-seq:
      #   response.should have_text(expected)
      #   response.should_not have_text(expected)
      #
      # Accepts a String or a Regexp, matching a String using ==
      # and a Regexp using =~.
      #
      # If response_or_text has a #body, then that is used as to match against
      # else it uses response_or_text
      #
      # Use this instead of <tt>response.should have_tag()</tt>
      # when you want to match the whole string or whole body
      #
      # == Examples
      #
      #   response.should have_text("This is the expected text")
      def be_valid
        ArBeValid.new
      end
    
    end
  end
end
