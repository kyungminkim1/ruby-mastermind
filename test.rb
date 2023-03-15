require './mastermind'

comp_code = Code.new
puts "Computer's secret code is: #{comp_code.digits}"
code = Code.new(7234)
board = Board.new
board.set_secret_code(code)
