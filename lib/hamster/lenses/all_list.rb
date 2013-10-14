require "hamster/list"
require "singleton"

class Hamster::Lenses::AllList
  include Singleton
  include Hamster::Lenses::Lense

  def get(list)
    check_not_nil(list)
    list
  end

end
