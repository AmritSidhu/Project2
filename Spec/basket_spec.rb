require 'basket'

describe Basket do
  it "is empty" do
    basket = Basket.new
    expect(basket.show_basket['FR1']).to eq(0)
    expect(basket.show_basket['SR1']).to eq(0)
    expect(basket.show_basket['CF1']).to eq(0)
  end

  it "add products" do
    basket = Basket.new
    basket.add_product('FR1')
    expect(basket.show_basket['FR1']).to eq(1)
    expect(basket.show_basket['SR1']).to eq(0)
    expect(basket.show_basket['CF1']).to eq(0)
  end

  it "does not add invalid product" do
    basket = Basket.new
    basket.add_product('AAAAA')
    expect(basket.show_basket['FR1']).to eq(0)
    expect(basket.show_basket['SR1']).to eq(0)
    expect(basket.show_basket['CF1']).to eq(0)
  end

  it "remove products" do
    basket = Basket.new
    basket.add_product('SR1')
    basket.add_product('CF1')
    basket.remove_product('SR1')
    expect(basket.show_basket['FR1']).to eq(0)
    expect(basket.show_basket['SR1']).to eq(0)
    expect(basket.show_basket['CF1']).to eq(1)
  end

  it "does not remove invalid product" do
    basket = Basket.new
    basket.remove_product('AAAAA')
    expect(basket.show_basket['FR1']).to eq(0)
    expect(basket.show_basket['SR1']).to eq(0)
    expect(basket.show_basket['CF1']).to eq(0)
  end

  it "will calculate total" do
    basket = Basket.new
    basket.add_product('FR1')
    basket.add_product('SR1')
    basket.add_product('CF1')
    expect(basket.total).to eq(1934)
  end

  it "will apply discount, buy-one-get-one-free on fruit tea" do
    basket = Basket.new
    basket.add_product('FR1')
    basket.add_product('FR1')
    expect(basket.bogof).to eq(311)
  end

  it "will apply discount, 3 or more SR1 will drop to 4.50" do
    basket = Basket.new
    basket.add_product('SR1')
    basket.add_product('SR1')
    basket.add_product('SR1')
    expect(basket.discount_strawberries).to eq(1350)
  end

  it "will apply multiple discount" do
    basket = Basket.new
    basket.add_product('FR1')
    basket.add_product('SR1')
    basket.add_product('FR1')
    basket.add_product('FR1')
    basket.add_product('CF1')
    expect(basket.overall_discount).to eq(2245)
  end

  it "will apply the correct discount" do
    basket = Basket.new
    basket.add_product('SR1')
    basket.add_product('SR1')
    basket.add_product('FR1')
    basket.add_product('SR1')
    expect(basket.overall_discount).to eq(1661)
  end

end
