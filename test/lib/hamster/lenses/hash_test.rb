require_relative '../../../test_helper'
require "hamster/hash"

describe Hamster::Lenses::Hash do
  before do
    @hash = Hamster.hash(key: :value)
    @lense = Hamster::Lenses::Hash.lense(:key)
  end

  it 'must get value' do
    @lense.get(@hash).must_equal :value
  end

  it 'must put value via value' do
    @lense.put(@hash, :new_value).must_equal Hamster.hash(key: :new_value)
  end

  it 'must put value via block' do
    @lense.put(@hash) { |old| old.to_s }.must_equal Hamster.hash(key: 'value')
  end

end
