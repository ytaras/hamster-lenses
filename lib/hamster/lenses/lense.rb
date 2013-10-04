require "preconditions"

module Hamster::Lenses
  module Lense
    def self.included(base)
      base.send :include, Preconditions
      base.send :include, Hamster::Lenses::DSL
    end
    def and_then(other)
      Composed.new(self, other)
    end
  end
end
