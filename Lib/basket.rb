class Basket

  def initialize
    @hash = {'FR1' => 0,
             'SR1' => 0,
             'CF1' => 0}
  end

  def show_basket
    @hash
  end

  def add_product(p_code)
    if @hash.key?(p_code)
      @hash[p_code] = @hash[p_code] + 1
    else
      print("Error")
    end
  end

  def remove_product(p_code)
    if @hash.key?(p_code)
      if @hash[p_code] > 0
        @hash[p_code] = @hash[p_code] - 1
      else
        print("Error")
      end
    else
      print("Error")
    end
  end




end
