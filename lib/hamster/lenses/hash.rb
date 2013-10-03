require "preconditions"

module Hamster::Lenses
  class Hash
    include Hamster::Lenses::Lense

    attr_reader :key

    def initialize(key)
      @key = key
    end

    def get(hash)
      check_not_nil(hash)
      hash[key]
    end

    def put(hash, new_value = Hamster::Undefined, &block)
      check_not_nil(hash)
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
