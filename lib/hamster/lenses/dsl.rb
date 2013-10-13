module Hamster::Lenses::DSL

  def [](key)
    self.and_then case key
                  when Fixnum
                    Hamster::Lenses.list(key)
                  else
                    Hamster::Lenses.hashmap(key)
                  end
  end

end
