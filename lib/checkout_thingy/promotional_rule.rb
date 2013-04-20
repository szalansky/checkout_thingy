class PromotionalRule
  def initialize(&block)
    @block = block
  end

  def apply_discount(items, current_total)
    @block.call(items, current_total)
  end
end