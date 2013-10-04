require_relative '../../../test_helper'

describe Hamster::Lenses::Id do
  subject { Hamster::Lenses::Id.new }

  it 'must get value' do
    subject.get(:v).must_equal :v
  end

  it 'must raise on nils' do
    assert_raises(ArgumentError) { subject.get(nil) }
    assert_raises(ArgumentError) { subject.put(nil) }
  end

  it 'must put value' do
    subject.put(:v, :new_v).must_equal :new_v
    subject.put(:v, &:to_s).must_equal 'v'
  end
end
