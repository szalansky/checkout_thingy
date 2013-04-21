require 'spec_helper'

describe Checkout do

  describe '#initialize' do

    let(:checkout) { Checkout.new }
    it { checkout.items.count.should eq(0) }
    it { checkout.total.should eq(0) }
    it { checkout.promotional_rules.count.should eq(0) }
  
  end

  describe '#scan' do

    let(:checkout) { Checkout.new }
    let(:item) { Item.new('002', 'Item', 9.50) }

    it 'adds item' do
      checkout.scan(item)
      checkout.items.count.should eq(1)
    end

  end

  describe '#total' do

    let(:lavender_heart) { Item.new('001', 'Lavender heart', 9.25) }
    let(:cufflinks) { Item.new('002', 'Cufflinks', 45.00) }
    let(:t_shirt) { Item.new('003', 'T-shirt', 19.95) }

    context 'promotional rules' do

      let(:ten_percent_discount) do
        PromotionalRule.new do |items, current_total|
          current_total > 60.00 ? 0.1 * current_total : 0
        end
      end

      let(:lavender_hearts_discount) do
        PromotionalRule.new do |items, current_total|
          lavender_hearts = items.count { |item| item.code.eql? '001' }
          lavender_hearts > 1 ? lavender_hearts * 0.75 : 0
        end
      end

      # Order in which discounts are applied matters:
      #
      #  raw_total = 9.25 * 2 + 45.00 + 19.95 = 83.45 (2 lavenders selected and total price above 60£)
      #
      # Apply discount for lavenders first 
      #   (raw_total - 2 * 0.75) * 0.9 = 73.755 ~ 73.76
      # Apply discount for total price first
      #   raw_total * 0.9 - 2 * 0.75 = 73.605 ~ 73.61
      let(:checkout) { Checkout.new([lavender_hearts_discount, ten_percent_discount]) }
      let(:another_checkout) { Checkout.new([lavender_hearts_discount, ten_percent_discount]) }

      it 'has two promotional rules' do
        checkout.promotional_rules.count.should eq(2)
      end

      it 'works for case #1' do
        checkout.scan(lavender_heart)
        checkout.scan(t_shirt)
        checkout.scan(cufflinks)
        checkout.total.should eq(66.78)
      end

      it 'works for case #2' do
        2.times { checkout.scan(lavender_heart) }
        checkout.scan(t_shirt)
        checkout.total.should eq(36.95)
      end

      it 'works for case #3' do
        2.times { checkout.scan(lavender_heart) }
        checkout.scan(t_shirt)
        checkout.scan(cufflinks)
        checkout.total.should eq(73.76)
      end

      it 'returns different discount for reversed order of promotional rules' do
        checkout.promotional_rules.reverse!
        2.times { checkout.scan(lavender_heart) }
        checkout.scan(t_shirt)
        checkout.scan(cufflinks)
        checkout.total.should eq(73.61)
      end
      
    end

    context 'no promotional rules' do
    
      let(:checkout) { Checkout.new }
      let(:another_checkout) { Checkout.new }
      
      it 'returns total price equal to the sum of prices' do
        checkout.scan(lavender_heart)
        checkout.scan(cufflinks)
        checkout.scan(t_shirt)
        another_checkout.scan(cufflinks)
        another_checkout.scan(cufflinks)
        checkout.total.should eq( 74.20 )
        another_checkout.total.should eq( 90.00 )
      end
      
    end

  end

end