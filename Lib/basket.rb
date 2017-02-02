require 'sqlite3'
require './products.rb'
class User
  def initialize
    @hash = {'FR1' => 0,
             'SR1' => 0,
             'CF1' => 0}
    @hash2 = Product.new
  end

  def show_basket
    @hash
  end

  def show_product_list
    @hash2
  end

  def add_product(p_code)
    if @hash.key?(p_code)
      @hash[p_code] = @hash[p_code] + 1
    end
  end

  def remove_product(p_code)
    if @hash.key?(p_code)
      if @hash[p_code] > 0
        @hash[p_code] = @hash[p_code] - 1
      end
    end
  end

  def total
    arr = @hash.map { |key, value| value * @hash2[key] if @hash2.key? key }
    sum = 0
    arr.each { |x| sum += x }
    sum
  end

  def finished
    overall = overall_discount
    @hash = { "FR1" => 0,
              "SR1" => 0,
              "CF1" => 0,
    }
    return "Total: #{overall / 100.00}, your basket is now empty!"
  end

  def bogof
    if @hash['FR1'] > 1 && @hash['FR1'] % 2 == 0
       ((@hash['FR1'] / 2) * 311)
     elsif @hash['FR1'] > 1
       (((@hash['FR1'] - 1)/2 * 311) + 311)
     elsif @hash['FR1'] <= 1
       (@hash['FR1'] * 311)
     end
  end

#refactor, Change names of variables and defs
  def discount_strawberries
    if @hash['SR1'] >= 3
      @hash['SR1'] * 450
    else
      @hash['SR1'] * 500
    end
  end

  def overall_discount
    (bogof + discount_strawberries + (@hash["CF1"] * 1123))
  end
end

class Staff < User
 def staff_id(n)
      begin
        db = SQLite3::Database.open "Spec/test.db"
        a = db.execute("SELECT Staff_ID FROM test WHERE Staff_ID = '#{n}'")
      rescue SQLite3::Exception => e
        puts "Exception occurred"
        puts e
      ensure
        db.close if db
      end
      return false if a == [] ; true
  end
end

class Loyalty < User
  def loyalty_id(n)
    begin
      db = SQLite3::Database.open "Spec/test.db"
      a = db.execute("SELECT LCD FROM test WHERE LCD = '#{n}'")
    rescue SQLite3::Exception => e
      puts "Exception occurred"
      puts e
    ensure
      db.close if db
    end
      return false if a == [] ; true
  end
end
=begin
class Employee < User
  def employment_length(n)
      begin
        db = SQLite3::Database.open "Spec/test.db"
        a = db.execute("SELECT Length FROM test WHERE Length = '#{n}'")
      rescue SQLite3::Exception => e
        puts "Exception occurred"
        puts e
      ensure
        db.close if db
      end
        return false if a == [] ; false
  end

  def user_discount(n,c)
    if staff_id == true
      if employment_length(n) >= 6
        return n.overall_discount
      end
    end
  end
end
=end
