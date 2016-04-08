class Piece
  attr_reader :color
  def initialize(color)
    @v_diff
    @h_diff
    @color = color
  end

  def get_diffs(initial_pos, end_pos)
    @v_diff = initial_pos[0] - end_pos[0]
    @h_diff = initial_pos[1] - end_pos[1]
  end

  def check_horizontal
    @h_diff != 0 ? @h_diff : false
  end

  def check_vertical
    @v_diff != 0 ? @v_diff : false
  end

  def check_diagonal
    @v_diff == @h_diff || @v_diff == - @h_diff ? @v_diff : false
  end
end

class Rook < Piece
  def check_move(initial_pos, end_pos)
    get_diffs(initial_pos, end_pos)
    if check_horizontal && !check_vertical || check_vertical && !check_horizontal
      puts "LEGAL"
    else
      puts "ILLEGAL"
    end
  end
end

class Queen < Piece
  def check_move(initial_pos, end_pos)
    get_diffs(initial_pos, end_pos)
    if check_horizontal && !check_vertical || check_vertical && !check_horizontal || check_diagonal
      puts "LEGAL"
    else
      puts "ILLEGAL"
    end
  end
end

class Pawn < Piece
  def initialize(first_move, color)
    @first_move = first_move
    super(color)
  end

  def check_move(initial_pos, end_pos)
    get_diffs(initial_pos, end_pos)
    if @first_move
      if check_vertical == 2 && !check_horizontal || check_vertical == - 2 && !check_horizontal || check_vertical == 1 && !check_horizontal || check_vertical == - 1 && !check_horizontal
        puts "LEGAL"
      else
        puts "ILLEGAL"
      end
    else
      if check_vertical == 1 && !check_horizontal || check_vertical == - 1 && !check_horizontal
        puts "LEGAL"
      else
        puts "ILLEGAL"
      end
    end
  end
end

class Bishop < Piece
  def check_move(initial_pos, end_pos)
    get_diffs(initial_pos, end_pos)
    if check_diagonal
      puts "LEGAL"
    else
      puts "ILLEGAL"
    end
  end
end

class King < Piece
  def check_move(initial_pos, end_pos)
    get_diffs(initial_pos, end_pos)
    if check_vertical == 1 && !check_horizontal || check_vertical == - 1 && !check_horizontal || check_horizontal == 1 && !check_vertical || check_horizontal == - 1 && !check_vertical || check_diagonal == 1 || check_diagonal == - 1
      puts "LEGAL"
    else
      puts "ILLEGAL"
    end
  end
end

class Knight < Piece
  def check_move(initial_pos, end_pos)
    get_diffs(initial_pos, end_pos)
    if check_horizontal == 2 || check_horizontal == - 2
      if check_vertical == 1 || check_vertical == - 1
        puts "LEGAL"
      else
        puts "ILLEGAL"
      end
    elsif check_horizontal == 1 || check_horizontal == - 1
      if check_vertical == 2 || check_vertical == - 2
        puts "LEGAL"
      else
        puts "ILLEGAL"
      end
    else
      puts "ILLEGAL"
    end
  end
end

class Board
  attr_reader :board, :initial_spaces_black_pawns, :initial_spaces_white_pawns
  def initialize
    @board = []
    @initial_spaces_black_pawns = [[1,0],[1,1],[1,2],[1,3],[1,4],[1,5],[1,6],[1,7]]
    @initial_spaces_white_pawns = [[6,0],[6,1],[6,2],[6,3],[6,4],[6,5],[6,6],[6,7]]
  end

  def load_board
    board_file = File.readlines("complex_board.txt")
    board_file.each_with_index do |line, index|
      @board[index] = line.split(" ")
    end
    convert_to_sym
    #print "#{@board[0]}\n#{@board[1]}\n#{@board[2]}\n#{@board[3]}\n#{@board[4]}\n#{@board[5]}\n#{@board[6]}\n#{@board[7]}\n"
  end

  def convert_to_sym
    @board.each do |line|
      line.each do |square|
        if square != "--"
          square = square.to_sym
        end
      end
    end
  end

  def translate_coordinates(coordinate)
    h_coord = coordinate.split("")[0].to_s
    v_coord = coordinate.split("")[1].to_i
    translation = [0,0]
    h_index = "a"
    h_index_ord = 0
    v_index = 8
    while h_index < h_coord
      if h_coord != h_index
        translation[1] += 1
        h_index_ord = h_index.ord + 1
        h_index = h_index_ord.chr
      end
    end
    while v_index > v_coord
      if v_coord != v_index
        translation[0] += 1
        v_index -= 1
      end
    end
    translation
  end
end

class Game
  def initialize
    @movements = []
  end

  def get_movements
    moves_file = File.readlines("complex_moves.txt")
    moves_file.each_with_index do |line, index|
      @movements[index] = line.split(" ")
    end
  end

  def validate(board1)
    @movements.each do |move|
      coord_1 = board1.translate_coordinates(move[0])
      coord_2 = board1.translate_coordinates(move[1])
      space1 = board1.board[board1.translate_coordinates(move[0])[0]][board1.translate_coordinates(move[0])[1]]
      piece1 = which_piece(space1, move, board1)
      space2 = board1.board[board1.translate_coordinates(move[1])[0]][board1.translate_coordinates(move[1])[1]]
      piece2 = which_piece(space2, move, board1)
      if piece1
        if !piece2
          piece1.check_move(coord_1, coord_2)
        else
          #puts "There's a piece on the destination"
          if piece1.color == piece2.color
            puts "ILLEGAL"
          else
            puts "LEGAL"
          end
        end
      else
        puts "ILLEGAL"
      end
    end
  end

  def check_if_pawn_initial_pos(move, color, board1)
    if color == "black"
      board1.initial_spaces_black_pawns.find(move)
    elsif color =="white"
      board1.initial_spaces_white_pawns.find(move)
    end
  end

  def which_piece(space, move, board1)
    if space != "--"
      space = space.to_sym
    end
    case space
    when :bP
      initial = check_if_pawn_initial_pos(move,"black", board1)
      black_pawn = Pawn.new(true, "black")
    when :wP
      initial = check_if_pawn_initial_pos(move,"white", board1)
      white_pawn = Pawn.new(true, "white")
    when :bR
      balck_rook = Rook.new("black")
    when :wR
      white_rook = Rook.new("white")
    when :bN
      black_knight = Knight.new("black")
    when :wN
      white_knight = Knight.new("white")
    when :bB
      black_bishop = Bishop.new("black")
    when :wB
      white_bishop = Bishop.new("white")
    when :bQ
      black_queen = Queen.new("black")
    when :wQ
      white_queen = Queen.new("white")
    when :bK
      black_king = King.new("black")
    when :wK
      white_king = King.new("white")
    when "--"
      false
    end
  end
end

board1 = Board.new
board1.load_board

game1 = Game.new
game1.get_movements
game1.validate(board1)
