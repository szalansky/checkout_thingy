require 'active_support/core_ext'

class Checkout

  attr_accessor :items

  def initialize(promotional_rules)
    @promotional_rules = promotional_rules
    @items = []
  end

  def scan(item)
    @items << item
  end

  def total
    current_total = raw_total
    @promotional_rules.each do |rule|
      current_total -= rule.apply_discount(items, current_total)
    end
    current_total.round(2)
  end

  private
    def raw_total
      return items.sum { |item| item.price } 
    end
end
