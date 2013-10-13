require_relative '../../../test_helper'

describe Hamster::Lenses::DSL do
  subject { Hamster::Lenses }
  before do
    @lense = subject.hashmap(:key)
  end

  it 'must define [] as hash' do
    @lense[:second].must_equal subject.
      hashmap(:key).and_then subject.hashmap(:second)
  end

  it 'must define [] as list' do
    @lense[1].must_equal subject.
      hashmap(:key).and_then subject.list(1)
  end
end
