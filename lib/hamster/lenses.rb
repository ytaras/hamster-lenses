require "hamster/lenses/version"
require "hamster/lenses/lense"
require "hamster/lenses/hash"
require "hamster/lenses/composed"

module Hamster::Lenses
  def self.hashmap(key)
    self::Hash.new(key)
  end
end

# TODO @ytaras Lense convenience DSL
# TODO @ytaras List lenses
