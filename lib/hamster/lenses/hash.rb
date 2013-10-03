module Hamster::Lenses
  class Hash
    include Hamster::Lenses::Lense

    attr_reader :key

    def self.lense(key)
      new(key)
    end

    def initialize(key)
      @key = key
    end

    def get(hash)
      hash[key]
    end

    def put(hash, new_value = Hamster::Undefined, &block)
      hash.put(key, new_value, &block)
    end

    def to_s
      "[#{key.inspect}]"
    end

    def ==(other)
      key == other.key
    end

  end
end
