require "hamster/list"
require "singleton"

module Hamster::Lenses
  class AllList
    include Singleton
    include Hamster::Lenses::Lense

    def get(list)
      check_not_nil(list)
      list
    end

    def put(list, value = Hamster::Undefined, &block)
      check_not_nil(list)
      list.map do |x|
        if value == Hamster::Undefined
          block.call(x)
        else
          value
        end
      end
    end

    def and_then(other)
      AllListComposed.new(self, other)
    end

  end

  class AllListComposed
    include Lense

    attr_reader :lense1, :lense2

    def initialize(lense1, lense2)
      check_not_nil(lense1)
      check_not_nil(lense2)
      @lense1 = lense1
      @lense2 = lense2
    end

    def get(object)
      lense1.get(object).map { |x| lense2.get(x) }
    end

    def put(object, value = Hamster::Undefined, &block)
      lense1.put(object) do |inner|
        lense2.put(inner, value, &block)
      end
    end

  end

end
