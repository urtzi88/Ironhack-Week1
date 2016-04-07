class ShoppingCart
  def initialize
    @pricelist = {}
    @items = []
  end

  def add_item_to_cart(item)
    key = item.to_s
    object = [key, @pricelist[item].to_i]
    @items << object
  end

  def show
    @items.each_with_index do |item, index|
      puts "#{index + 1} #{@items[index][0]}: #{@items[index][1]}$"
    end
  end

  def cost
    total_cost = @items.reduce(0) {|sum, x| sum += x[1]}
    puts "Total: #{total_cost}"
  end

  def load_prices
    priceli = File.readlines('prices')
    priceli.each do |item|
      @pricelist[item.split(' ')[0].to_sym] = item.split(' ')[1].split('$')[0]
    end
  end
end

cart = ShoppingCart.new
cart.load_prices
cart.add_item_to_cart :bananas
cart.add_item_to_cart :oranges
cart.add_item_to_cart :grapes
cart.add_item_to_cart :bananas

cart.show
cart.cost
