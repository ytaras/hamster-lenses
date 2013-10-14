require_relative '../../../test_helper'
require "hamster/list"

describe Hamster::Lenses::List do
  subject { Hamster::Lenses }
  before do
    @list = Hamster.list(*%i(one two three))
  end

  it 'must get all values' do
    subject.all_list.get(@list).must_equal @list
  end

  it 'must compose with hash on get'
  it 'must put all values'
  it 'must put all values with block'
  it 'must compose with hash on put'

end
