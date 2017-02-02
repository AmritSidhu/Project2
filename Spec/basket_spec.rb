require 'basket'

describe User do

  before(:each) do
    @basket = User.new
  end

  it "is empty" do
    expect(basket.show_basket['FR1']).to eq(0)
    expect(basket.show_basket['SR1']).to eq(0)
    expect(basket.show_basket['CF1']).to eq(0)
  end

  it "add products" do
    basket = User.new
    basket.add_product('FR1')
    expect(basket.show_basket['FR1']).to eq(1)
    expect(basket.show_basket['SR1']).to eq(0)
    expect(basket.show_basket['CF1']).to eq(0)
  end

  it "does not add invalid product" do
    basket = User.new
    basket.add_product('AAAAA')
    expect(basket.show_basket['FR1']).to eq(0)
    expect(basket.show_basket['SR1']).to eq(0)
    expect(basket.show_basket['CF1']).to eq(0)
  end

  it "remove products" do
    basket = User.new
    basket.add_product('SR1')
    basket.add_product('CF1')
    basket.remove_product('SR1')
    expect(basket.show_basket['FR1']).to eq(0)
    expect(basket.show_basket['SR1']).to eq(0)
    expect(basket.show_basket['CF1']).to eq(1)
  end

  it "does not remove invalid product" do
    basket = User.new
    basket.remove_product('AAAAA')
    expect(basket.show_basket['FR1']).to eq(0)
    expect(basket.show_basket['SR1']).to eq(0)
    expect(basket.show_basket['CF1']).to eq(0)
  end

  it "will calculate total" do
    basket = User.new
    basket.add_product('FR1')
    basket.add_product('SR1')
    basket.add_product('CF1')
    expect(basket.total).to eq(1934)
  end

  it "will apply discount, buy-one-get-one-free on fruit tea" do
    basket = User.new
    basket.add_product('FR1')
    basket.add_product('FR1')
    expect(basket.bogof).to eq(311)
  end

  it "will apply discount, 3 or more SR1 will drop to 4.50" do
    basket = User.new
    basket.add_product('SR1')
    basket.add_product('SR1')
    basket.add_product('SR1')
    expect(basket.discount_strawberries).to eq(1350)
  end

  it "will apply multiple discount" do
    basket = User.new
    basket.add_product('FR1')
    basket.add_product('SR1')
    basket.add_product('FR1')
    basket.add_product('FR1')
    basket.add_product('CF1')
    basket.add_product('CF1')
    expect(basket.overall_discount).to eq(3368)
  end

  it "will apply the correct discount" do
    basket = User.new
    basket.add_product('SR1')
    basket.add_product('SR1')
    basket.add_product('FR1')
    basket.add_product('SR1')
    expect(basket.overall_discount).to eq(1661)
  end

  it "will empty basket after displaying total cost" do
    basket = User.new
    basket.add_product('FR1')
    expect(basket.finished).to eq("Total: 3.11, your basket is now empty!")
    basket.add_product('SR1')
    expect(basket.finished).to eq("Total: 5.0, your basket is now empty!")
  end

  it "returns true if a Staff_ID code exists" do
    user = Staff.new
    expect(user.staff_id(1001)).to eq(true)
  end

  it "returns true if a LCD code exists" do
    user = Loyalty.new
    expect(user.loyalty_id(12345)).to eq(true)
  end
=begin
  it "takes 10% off an item if valid staff id and employment length" do
   user = Employee.new
   user.add_product("FR1")
   user.add_product("SR1")
   user.add_product("FR1")
   user.add_product("SR1")
   user.add_product("SR1")
   expect(user.user_discount).to eq(14.94)
 end
=end
end
