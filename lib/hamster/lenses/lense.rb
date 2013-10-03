module Hamster::Lenses
  module Lense
    def and_then(other)
      Composed.new(self, other)
    end
  end
end
