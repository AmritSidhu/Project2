class Basket

  def initialize
    @basket = { "FR1" => 0,
                "SR1" => 0,
                "CF1" => 0,
    }
  end

  def display_basket
    return "#{@basket} Cost = £#{total}"
  end

  def total
    ((@basket["FR1"] * 311) + (@basket["SR1"] * 500) + (@basket["CF1"] * 1123)) / 100.00
  end

  def add_product(product)
    @basket[product] = @basket[product] + 1
  end

  def remove_product(product)
    if @basket[product] > 0
      @basket[product] = @basket[product] - 1
    end
  end

end

def checkout
  Basket.new
end
