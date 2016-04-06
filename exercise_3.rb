class Room
  attr_accessor :win_condition, :colission
  def initialize(description, doors, win_condition)
    @description = description
    @doors = doors
    @win_condition = win_condition
    @colission = false
  end
  def print_room
    puts @description
    puts "There are #{@doors.length} doors on this room"
    print "Exits: #{@doors} \n"
  end
end

class Player
  attr_accessor :win, :name
  def initialize
    @name
    @win = false
  end
  def get_name
    puts "Write your name:"
    @name = gets.chomp
  end
  def decision(index1, index2, rooms_array)
    puts "#{@name}, which way do you want to go? (N/S/E/W)"
    direction = gets.chomp.upcase
    case direction
    when "N"
      #move north
      move_north(index1, index2, rooms_array)
    when "S"
      #move south
      move_south(index1, index2, rooms_array)
    when "E"
      #move east
      move_east(index1, index2, rooms_array)
    when "W"
      #move west
      move_west(index1, index2, rooms_array)
    else
      puts "That's not a valid direction"
      decision
    end
  end
  def move_north(index1, index2, rooms_array)
    if index1 >= rooms_array.length - 1 || rooms_array[index1 + 1][index2] == nil
      puts "The door is not this way!"
      rooms_array[index1][index2].colission = true
    else
      index1 += 1
    end
    index_array = [index1, index2]
  end
  def move_south(index1, index2, rooms_array)
    if index1 <= 0 || rooms_array[index1 - 1][index2] == nil
      puts "The door is not this way!"
      rooms_array[index1][index2].colission = true
    else
      index1 -= 1
    end
    index_array = [index1, index2]
  end
  def move_east(index1, index2, rooms_array)
    if index2 >= rooms_array.length - 1 || rooms_array[index1][index2 + 1] == nil
      puts "The door is not this way!"
      rooms_array[index1][index2].colission = true
    else
      index2 += 1
    end
    index_array = [index1, index2]
  end
  def move_west(index1, index2, rooms_array)
    if index2 <= 0 || rooms_array[index1][index2 - 1] == nil
      puts "The door is not this way!"
      rooms_array[index1][index2].colission = true
    else
      index2 -= 1
    end
    index_array = [index1, index2]
  end
end

def game(rooms_array)
  player1 = Player.new
  player1.get_name
  index1 = 0
  index2 = 0
  index_array = [index1, index2]
  while !player1.win
    if !rooms_array[index1][index2].colission
      rooms_array[index1][index2].print_room
    else
      rooms_array[index1][index2].colission = false
    end
    index_array = player1.decision(index1, index2, rooms_array)
    index1 = index_array[0]
    index2 = index_array[1]
    if rooms_array[index1][index2] != nil && rooms_array[index1][index2].win_condition == true
      player1.win = true
      puts "Congratulations #{player1.name}, you have reached the last room"
    end
  end
end

room1 = Room.new("Initial room", ["N","E"], false)
room2 = Room.new("Room2", ["E", "W"], false)
room3 = Room.new("Room3", ["N","W"], false)
room4 = Room.new("Room4", ["S"], false)
room5 = Room.new("Room5", ["N", "S"], false)
room6 = Room.new("Room6", ["E"], false)
room7 = Room.new("Room7", ["S","E","W"], false)
room8 = Room.new("Room8", ["N","W"], false)
room9 = Room.new("Final Room", ["S"], true)

rooms_array = [
  [room1, room2, room3, nil],
  [room4, nil, room5, nil],
  [nil, room6, room7, room8],
  [nil, nil, nil, room9]
]

game(rooms_array)
