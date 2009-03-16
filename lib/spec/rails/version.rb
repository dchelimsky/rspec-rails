module Spec # :nodoc:
  module Rails # :nodoc:
    module VERSION # :nodoc:
      unless defined? MAJOR
        RELEASE = false
        MAJOR  = 1
        MINOR  = 2
        TINY   = 0
        BUILD = lambda {RELEASE ? nil : Time.new.to_i}

        STRING = [MAJOR, MINOR, TINY, BUILD.call].compact.join('.')

        SUMMARY = "rspec-rails #{STRING}"
      end
    end
  end
end
