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

  def total
    @hash2 = {'FR1' => 311,
              'SR1' => 500,
              'CF1' => 1123}

    arr = @hash.map {|key, value| value * @hash2[key] if @hash2.key? key}
    sum = 0
    arr.each { |x| sum += x }
    sum
  end

  def bogof
    if @hash['FR1'] > 1 && @hash['FR1'] % 2 == 0
       (@hash['FR1'] / 2) * 311
     elsif @hash['FR1'] > 1
       ((@hash['FR1'] - 1)/2 * 311) + 311
     elsif @hash['FR1'] <= 1
       @hash['FR1'] * 311
     end
  end

  def discount_strawberries
    if @hash['SR1'] >= 3
      @hash['SR1'] * 450
    else
      @hash['SR1'] * 500
    end
  end

  def overall_discount
    bogof + discount_strawberries + (@hash["CF1"] * 1123)
  end

end
