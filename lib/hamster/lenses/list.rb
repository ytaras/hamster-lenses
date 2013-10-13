require "hamster/lenses/lense"

class Hamster::Lenses::List
  include Hamster::Lenses::Lense

  attr_reader :index

  def initialize(index)
    @index = index
  end

  def get(list)
    check_not_nil(list)
    list[index]
  end

  def put(list, new_value = Hamster::Undefined, &block)
    check_not_nil(list)
    new_value = block.call(get(list)) if block
    tail = list.drop(index + 1)
    tail = tail.cons(new_value) unless new_value == Hamster::Undefined
    list.take(index) + tail
  end

end
