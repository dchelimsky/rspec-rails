module Spec
  module Rails
    module VERSION #:nodoc:
      unless defined? MAJOR
        MAJOR  = 1
        MINOR  = 1
        TINY   = 99
        MINESCULE = 12

        STRING = [MAJOR, MINOR, TINY, MINESCULE].compact.join('.')

        SUMMARY = "rspec-rails #{STRING}"
      end
    end
  end
end