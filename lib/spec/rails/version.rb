module Spec # :nodoc:
  module Rails # :nodoc:
    module VERSION # :nodoc:
      unless defined? MAJOR
        MAJOR  = 1
        MINOR  = 2
        TINY   = 9
        PRE    = 'rc1'
      
        STRING = [MAJOR, MINOR, TINY, PRE].compact.join('.')

        SUMMARY = "rspec-rails #{STRING}"
      end
    end
  end
end
