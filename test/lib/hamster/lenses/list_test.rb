require_relative '../../../test_helper'
require "hamster/list"

describe Hamster::Lenses::List do
  subject { Hamster::Lenses }
  before do
    @list = Hamster.list(:first, :second, :third)

    @lenses = @list.size.times.map { |i| subject.list(i) }
  end

  it 'must get value' do
    @lenses[0].get(@list).must_equal :first
    @lenses[1].get(@list).must_equal :second
    @lenses[2].get(@list).must_equal :third
  end

  it 'must put value' do
    @lenses[0].put(@list, :updated).must_equal Hamster
      .list(:updated, :second, :third)
    @lenses[1].put(@list, :updated).must_equal Hamster
      .list(:first, :updated, :third)
    @lenses[2].put(@list, :updated).must_equal Hamster
      .list(:first, :second, :updated)
  end

  it 'must skip value on Undefined' do
    @lenses[0].put(@list).must_equal Hamster
      .list(:second, :third)
    @lenses[1].put(@list).must_equal Hamster
      .list(:first, :third)
    @lenses[2].put(@list).must_equal Hamster
      .list(:first, :second)
  end

  it 'must work with a block' do
    block = ->(i){ i.to_s }
    @lenses[0].put(@list, &block).must_equal Hamster
      .list('first', :second, :third)
    @lenses[1].put(@list, &block).must_equal Hamster
      .list(:first, 'second', :third)
    @lenses[2].put(@list, &block).must_equal Hamster
      .list(:first, :second, 'third')

  end

  it 'must be composable with hash' do
    hash = Hamster.hash(key: Hamster.list(:one, :two, :three))
    l1 = Hamster::Lenses.hashmap(:key)
    l2 = Hamster::Lenses.list(1)
    lense = l1.and_then l2

    lense.get(hash).must_equal :two
    lense.put(hash, :new).must_equal Hamster
      .hash(key: Hamster.list(:one, :new, :three))
    lense.put(hash, &:to_s).must_equal Hamster
      .hash(key: Hamster.list(:one, 'two', :three))
  end

end
