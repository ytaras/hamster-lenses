require 'hamster/list'

module Hamster::Lenses
  class Composed
    def self.lense(*lenses)
      new(*lenses)
    end

    def initialize(*lenses)
      @lenses = Hamster.list(*lenses)
    end

    def get(object)
      @lenses.reduce(object) { |current, lense| lense.get(current) }
    end

    def put(object, value)
      # Recursive function magic goes here - maybe something more
      # explicit needed?
      start = ->(x) { value }
      lense_executor = @lenses.reverse.reduce(start) { |f, lense|
        ->(x) {
          lense.put(x, &f)
        }
      }
      lense_executor.call(object)
    end
  end
end
