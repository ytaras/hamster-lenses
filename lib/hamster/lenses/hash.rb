module Hamster::Lenses
  class Hash
    def self.lense(key)
      new(key)
    end

    def initialize(key)
      @key = key
    end

    def get(hash)
      hash[@key]
    end

    def put(hash, new_value = Hamster::Undefined, &block)
      hash.put(@key, new_value, &block)
    end
  end
end
