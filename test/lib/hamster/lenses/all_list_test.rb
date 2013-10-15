require_relative '../../../test_helper'
require "hamster/list"

describe Hamster::Lenses::List do
  subject { Hamster::Lenses.all_list }
  before do
    @list = Hamster.list(:one, :two, :three)
  end

  it 'must get all values' do
    subject.get(@list).must_equal @list
  end

  it 'must put all values' do
    subject.put(@list, :value).must_equal Hamster
      .list *(3.times.map { :value})
  end

  it 'must put all values with block' do
    subject.put(@list, &:to_s).must_equal @list.map(&:to_s)
  end

  describe 'composed with hash' do
    before do
      @deep_list = @list.map { |x| Hamster.hash(key: x) }
    end

    it 'must get' do
      subject[:key].get(@deep_list).must_equal @list
    end

    it 'must put' do
      subject[:key].put(@deep_list, :value).must_equal @list.map {
        Hamster.hash(key: :value)
      }
    end

    it 'must put with block' do
      subject[:key].put(@deep_list, &:to_s).must_equal @list.map { |x|
        Hamster.hash(key: x.to_s)
      }
    end

  end

  describe 'composed in a complex way' do
    it 'must get'
    it 'must put'
    it 'must put with block'
  end


end
