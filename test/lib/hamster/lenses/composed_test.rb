require_relative '../../../test_helper'
require "hamster/hash"

describe Hamster::Lenses::Composed do
  H = Hamster

  before do
    @hash1 = H.hash(key: H.hash(inner: :value))
    @hash2 =
      H.hash(key: H.hash(other_inner: H.hash(inner_inner: :value2)))

    lense1 = Hamster::Lenses::Hash.lense(:key)
    lense2 = Hamster::Lenses::Hash.lense(:inner)
    lense2_2 = Hamster::Lenses::Hash.lense(:other_inner)
    lense3 = Hamster::Lenses::Hash.lense(:inner_inner)
    @composed_lense1 = Hamster::Lenses::Composed.lense(lense1, lense2)
    @composed_lense2 = Hamster::Lenses::Composed.lense(lense1, lense2_2, lense3)
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

end
