WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5],  # Middle row
  [6,7,8],  # Bottom row

  [0,3,6],  # Left column
  [1,4,7],  # Middle column
  [2,5,8],  # Right column

  [0,4,8],  # Top-Left cross
  [6,4,2]  # Bottom-Left cross
]

TURN_COUNT = 0

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def turn(board)
  puts "Please enter 1-9:"
  index = input_to_index(gets.strip)
  valid_move?(board, index) ? move(board, index) : turn(board)
end

def input_to_index(input)
  input.to_i - 1
end

def move(board, index, character)
  if board[index] === " "
    board[index] = character
    display_board(board)
  end
end

def valid_move?(board, index)
  if index > board.length - 1 || index < 0
    return false
  end
  !position_taken?(board, index)
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def draw?(board)
  full?(board) && !won?(board)
end

def empty?(board)
  board.select{|cell| cell == ' '}.length == 9
end

def full?(board)
  board.select{|cell| cell == 'X' || cell == "O"}.length == 9
end

def over?(board)
  won?(board) || draw?(board)
end

def winner(board)
  won?(board) ? board[won?(board)[0]] : nil
end

def won?(board)
  # The winning combo
  winning_combo = nil

  # Detect if board is empty
  if empty?(board)
    return false
  end

  # Detect if game has been won
  WIN_COMBINATIONS.each do |combo|
    cell_1 = combo[0]; cell_2 = combo[1]; cell_3 = combo[2]

    # If first position is empty, move to next combo immediately
    if !position_taken?(board, combo[0])
      next
    end

    # If the cells match
    cells_match = board[cell_1] == board[cell_2] && board[cell_1] == board[cell_3]
    # If first cell is X or O
    first_is_valid = board[cell_1] == "X" || board[cell_1] == "O"

    if first_is_valid && cells_match
      winning_combo = combo
      break
    end
  end

  return winning_combo != nil ? winning_combo : false
end
