require 'spec_helper'

describe Item do
  let(:item) { Item.new('001', 'biscuits', 1.50) }

  it 'assigns attributes correctly' do
    item.code.should eq('001')
    item.name.should eq('biscuits')
    item.price.should eq(1.50)
  end
end