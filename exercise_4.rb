require 'date'
class ShoppingCart
  def initialize
    @pricelist = {}
    @items = {}
  end

  def add_item_to_cart(item)
    if !@items[item]
      @items[item] = [@pricelist[item].to_i, 1, @pricelist[item].to_i, @pricelist[item].to_f]
    else
      @items[item][1] += 1
      @items[item][2] += @pricelist[item].to_i
      @items[item][3] += @pricelist[item].to_f
    end
  end

  def show
    index = 1
    puts "Number  | Amount | Item \t| Price Each    | Price Total   | With discount"
    @items.each do |key, value|
      puts "#{index} \t| #{value[1]} \t | #{key}: \t| #{value[0]}$ \t\t| #{value[2]}$ \t\t| #{value[3]}$"
      index += 1
    end
  end

  def cost
    total_cost = @items.reduce(0) {|sum, value| sum += value[1][3]}
    puts "Total: #{total_cost}"
  end

  def load_prices(date_of_today)
    priceli = File.readlines('prices')
    priceli.each do |item|
      if item.split(' ')[0] == "watermelon"
        if date_of_today.sunday
          @pricelist[item.split(' ')[0].to_sym] = item.split(' ')[1].split('$')[0].to_i * 2
        else
          @pricelist[item.split(' ')[0].to_sym] = item.split(' ')[1].split('$')[0].to_i
        end
      else
        @pricelist[item.split(' ')[0].to_sym] = item.split(' ')[date_of_today.season].split('$')[0]
      end
    end
  end

  def discounts
    #buy 2 apples and pay just 1
    if @items[:apples][1] >= 2
      num_apples = @items[:apples][1] / 2 + @items[:apples][1] % 2
      @items[:apples][3] = @pricelist[:apples].to_f * num_apples
      puts "Apples: buy 2 and pay 1"
    end
    #by 3 oranges and pay just 2
    if @items[:oranges][1] >= 3
      num_oranges = @items[:oranges][1] / 3 * 2 + @items[:oranges][1] % 3
      @items[:oranges][3] = @pricelist[:oranges].to_f * num_oranges
      puts "Oranges: buy 3 and pay 2"
    end
    if @items[:grapes][1] >= 4
      num_bananas = @items[:grapes][1] / 4
      if @items[:bananas]
        if @items[:bananas][3] > @pricelist[:bananas].to_f * num_bananas
          @items[:bananas][3] -= @pricelist[:bananas].to_f * num_bananas
        else
          @items[:bananas][3] = 0.0
        end
        puts "Grapes: buy 4 and get 1 bannana"
      end
    end
  end
end

class Season
  def initialize
    @today_date = Date.today
  end
  def season
    year_day = @today_date.yday().to_i
    if year_day >= 355 or year_day < 81
      4 #winter
    elsif year_day >= 81 and year_day < 173
      1 #spring
    elsif year_day >= 173 and year_day < 266
      2 #summer
    elsif year_day >= 266 and year_day < 355
      3 #autumn
    end
  end
  def sunday
    week_day = @today_date.wday.to_i
    week_day == 0 ? true : false #is sunday?
  end
end

cart = ShoppingCart.new
cart.load_prices(Season.new)


cart.add_item_to_cart :apples
cart.add_item_to_cart :apples
cart.add_item_to_cart :apples
cart.add_item_to_cart :apples
cart.add_item_to_cart :apples
cart.add_item_to_cart :bananas
cart.add_item_to_cart :grapes
cart.add_item_to_cart :grapes
cart.add_item_to_cart :grapes
cart.add_item_to_cart :grapes
cart.add_item_to_cart :grapes
cart.add_item_to_cart :grapes
cart.add_item_to_cart :grapes
cart.add_item_to_cart :grapes
cart.add_item_to_cart :oranges
cart.add_item_to_cart :oranges
cart.add_item_to_cart :oranges
cart.add_item_to_cart :oranges
cart.add_item_to_cart :oranges
cart.add_item_to_cart :oranges
cart.add_item_to_cart :watermelon


cart.discounts
cart.show
cart.cost
