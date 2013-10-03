require_relative '../../../test_helper'
require "hamster/hash"

describe Hamster::Lenses::Composed do
  H = Hamster

  subject { Hamster::Lenses }

  before do
    @hash1 = H.hash(key: H.hash(inner: :value))
    @hash2 =
      H.hash(key: H.hash(other_inner: H.hash(inner_inner: :value2)))

    lense1 = subject.hashmap(:key)
    lense2 = subject.hashmap(:inner)
    lense2_2 = subject.hashmap(:other_inner)
    lense3 = subject.hashmap(:inner_inner)
    @composed_lense1 = lense1.and_then(lense2)
    @composed_lense2 = lense1.and_then(lense2_2).and_then(lense3)
  end

  it 'should get 2 levels deep' do
    @composed_lense1.get(@hash1).must_equal :value
  end

  it 'should get 3 levels deep' do
    @composed_lense2.get(@hash2).must_equal :value2
  end

  it 'should put 2 levels deep' do
    @composed_lense1.put(@hash1, :new_value).
      must_equal H.hash(key: H.hash(inner: :new_value))
  end

  it 'should put 3 levels deep' do
    @composed_lense2.put(@hash2, :new_value).
      must_equal H.hash(key:
                        H.hash(other_inner: H.hash(inner_inner: :new_value)))
  end

  it 'should put block 2 levels deep' do
    @composed_lense1.put(@hash1, &:to_s)
      .must_equal H.hash(key: H.hash(inner: 'value'))
  end

  it 'should put block 3 levels deep' do
    @composed_lense2.put(@hash2, &:to_s)
      .must_equal H.hash(key: H.hash(other_inner:
                                     H.hash(inner_inner: 'value2')))
  end

  it 'should render itself' do
    @composed_lense1.to_s.must_equal '[:key] / [:inner]'
    @composed_lense2.to_s.must_equal '[:key] / [:other_inner] / [:inner_inner]'
  end

  it 'should define equal' do
    @composed_lense1.wont_equal @composed_lense2
    @composed_lense1.must_equal subject.hashmap(:key)
      .and_then(subject.hashmap :inner)
  end

  it 'should raise exception on and_then nil' do
    assert_raises(ArgumentError) { @composed_lense1.and_then nil }
  end

  it 'should raise exception on put or get nil' do
    assert_raises(ArgumentError) { @composed_lense1.put nil }
    assert_raises(ArgumentError) { @composed_lense1.get nil }
  end


end
