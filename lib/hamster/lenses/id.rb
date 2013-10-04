require "hamster/lenses/lense"

class Hamster::Lenses::Id
  include Hamster::Lenses::Lense

  def get(object)
    check_not_nil(object)
    object
  end

  def put(object, value = Hamster::Undefined, &block)
    check_not_nil(object)
    if value == Hamster::Undefined
      block.call(object)
    else
      value
    end
  end
end
