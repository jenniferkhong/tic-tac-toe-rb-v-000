WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [2, 4, 6]
]
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  index = input.to_i - 1
end

def move(board, index, character)
  board[index] = character
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board,index)
  if position_taken?(board, index) == true
    false
  elsif index.between?(0, 8) && position_taken?(board, index) == false
    true
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, character = current_player(board))
  else
    turn(board)
  end
  display_board(board)
end

def turn_count(board)
  counter = 0
  board.each do |x|
    if(x == "X" || x == "O")
      counter +-1
    end
  end
  return counter
end

def current_player(board)
  turn_count(board).even ? "X" : "O"
end

  def won?(board)
    WIN_COMBINATIONS.each do |win_combination|
      win_index_1 = win_combination[0];
      win_index_2 = win_combination[1];
      win_index_3 = win_combination[2];
      position_1 = board[win_index_1];
      position_2 = board[win_index_2];
      position_3 = board[win_index_3];
      if ((position_1 == x && position_2 == x && position_3 == x) ||
        (position_1 == o && position_2 == o && position_3 == o))
        return win_combination;
      else
        false
      end
    end
    return false;
  end

  def full?(board)
    return board.detect{|i| i == " "} ? false : true
  end

  def draw?(board)
    return full?(board) && !won?(board) ? true : false
  end

  def over?(board)
    return won?(board) || draw?(board) ? true : false
  end

  def winner(board)
    won_array = won?(board)
    won_array ? board[won_array[0]] : nil
  end

  def play(board)
    turn(board) until over?(board)
    if draw?(board)
      puts "Cat's Game!"
    elsif won?(board)
      puts "Congratulations #{winner(board)}!"
    end
  end