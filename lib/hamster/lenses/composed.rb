require "preconditions"

module Hamster::Lenses
  class Composed
    include Lense

    attr_reader :lense1, :lense2
    def self.lense(*lenses)
      lenses.reduce(&:and_then)
    end

    def initialize(lense1, lense2)
      check_not_nil(lense1)
      check_not_nil(lense2)
      @lense1 = lense1
      @lense2 = lense2
    end

    def get(object)
      lense2.get(lense1.get(object))
    end

    def put(object, value = Hamster::Undefined, &block)
      lense1.put(object) do |inner|
        lense2.put(inner, value, &block)
      end
    end

    def to_s
      "#{lense1.to_s} / #{lense2.to_s}"
    end

    def ==(other)
      other.is_a?(Composed) && lense1 == other.lense1 && lense2 == other.lense2
    end
  end
end
