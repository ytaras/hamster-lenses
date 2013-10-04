module Hamster::Lenses::DSL

  def [](key)
    self.and_then Hamster::Lenses.hashmap(key)
  end

end
