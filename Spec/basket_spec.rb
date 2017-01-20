require 'basket'

describe Basket do
  it "add product to basket" do
     new_basket = checkout
     new_basket.add_product("SR1")
     expect(new_basket.display_basket).to eq('{"FR1"=>0, "SR1"=>1, "CF1"=>0} Cost = £5.0')
  end

end
