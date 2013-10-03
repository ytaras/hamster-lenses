require 'hamster/list'

module Hamster::Lenses
  class Composed
    include Lense

    def self.lense(*lenses)
      lenses.reduce(&:and_then)
    end

    def initialize(lense1, lense2)
      @lense1 = lense1
      @lense2 = lense2
    end

    def get(object)
      @lense2.get(@lense1.get(object))
    end

    def put(object, value)
      inner = @lense1.get(object)
      new_inner = @lense2.put(inner, value)
      @lense1.put(object, new_inner)
    end
  end
end
