class Home
  attr_reader(:name, :city, :capacity, :price)

  def initialize(name, city, capacity, price)
    @name = name
    @city = city
    @capacity = capacity
    @price = price
  end
end

homes = [
  Home.new("Nizar's place", "San Juan", 2, 42),
  Home.new("Fernando's place", "Seville", 5, 47),
  Home.new("Josh's place", "Pittsburgh", 3, 41),
  Home.new("Gonzalo's place", "Málaga", 2, 45),
  Home.new("Ariel's place", "San Juan", 4, 49),
  Home.new("Urtzi's place", "Madrid", 2, 38),
  Home.new("Marta's place", "Seville", 3, 44),
  Home.new("John's place", "Bilbao", 4, 35),
  Home.new("Esther's place", "Madrid", 2, 45),
  Home.new("Rob's place", "San Juan", 4, 45)
]

def print_array(array)
	array.each do |item| 
		puts "#{item.name}, #{item.city}, #{item.price}, #{item.capacity}"
	end
end

#print_array(homes)

puts "Type price if you want to sort by price or capacity if you want to sort by capacity:"
sort_by = gets.chomp
puts "Type 1 if you want it on ascending order or 2 if you want it in descending order:"
sort_order = gets.chomp.to_i

puts "Sort by: #{sort_by} and Sorting order: #{sort_order}"
puts"------------------------------------------------"

def sort_homes(sort_by, sort_order, homes)
	sorted_homes = []
	if sort_by == "price"
		if sort_order == 1
			sorted_homes = homes.sort {|a, b| a.price <=> b.price}
		elsif sort_order == 2
			sorted_homes = homes.sort {|a, b| b.price <=> a.price}
		end
	elsif sort_by == "capacity"
		if sort_order == 1
			sorted_homes = homes.sort {|a, b| a.capacity <=> b.capacity}
		elsif sort_order == 2
			sorted_homes = homes.sort {|a, b| b.capacity <=> a.capacity}
		end
	end
	print_array(sorted_homes)
end

sort_homes(sort_by, sort_order, homes)

puts"------------------------------------------------"
puts "Please type in the city you want to filter by:"
filter_city = gets.chomp
puts"------------------------------------------------"

filter_city_homes = homes.select{|hm| hm.city == filter_city}
print_array(filter_city_homes)

average = filter_city_homes.reduce(0.0){|sum, x| sum += x.price}
average = average/filter_city_homes.length

puts"------------------------------------------------"
puts "Average price for #{filter_city} is $#{average}"
puts"------------------------------------------------"

puts "ALL HOMES."
puts"------------------------------------------------"

print_array(homes)

puts "Please type in the price that you would like to pay:"
user_price = gets.chomp.to_i
puts"------------------------------------------------"

priced_homes = homes.select{|hm| hm.price == user_price}
print_array(priced_homes)
puts"------------------------------------------------"


