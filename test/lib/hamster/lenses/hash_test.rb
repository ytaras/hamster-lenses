require_relative '../../../test_helper'
require "hamster/hash"

describe Hamster::Lenses::Hash do
  L = Hamster::Lenses::Hash
  before do
    @hash = Hamster.hash(key: :value)
    @lense = L.lense(:key)
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

  it 'must have render well' do
    @lense.to_s.must_equal '[:key]'
  end

  it 'must define equals' do
    @lense.must_equal L.lense(:key)
    @lense.wont_equal L.lense(:key1)
  end

  it 'must raise exception on nil object' do
    assert_raises(ArgumentError) { @lense.put(nil, :value) }
    assert_raises(ArgumentError) { @lense.get(nil, :value) }
  end

end
