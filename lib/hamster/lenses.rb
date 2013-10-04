require "hamster/lenses/version"
require "hamster/lenses/dsl"
require "hamster/lenses/lense"
require "hamster/lenses/hash"
require "hamster/lenses/composed"
require "hamster/lenses/id"

module Hamster::Lenses
  def self.hashmap(key)
    self::Hashmap.new(key)
  end
end

# TODO @ytaras Lense convenience DSL
# TODO @ytaras List lenses
