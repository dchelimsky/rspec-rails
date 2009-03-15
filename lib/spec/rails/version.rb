module Spec
  module Rails
    module VERSION #:nodoc:
      unless defined? MAJOR
        MAJOR  = 1
        MINOR  = 2
        TINY   = 0
        MINESCULE = nil

        STRING = [MAJOR, MINOR, TINY, MINESCULE].compact.join('.')

        SUMMARY = "rspec-rails #{STRING}"
      end
    end
  end
end