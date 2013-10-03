require "preconditions"

module Hamster::Lenses
  module Lense
    def self.included(base)
      base.send :include, Preconditions
    end
    def and_then(other)
      Composed.new(self, other)
    end
  end
end
