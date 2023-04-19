require './mastermind'

comp_code = Code.new
puts "Computer's secret code is: #{comp_code.digits}"
board = Board.new
board.set_secret_code(comp_code)

computer = Computer.new
player = Player.new
game = Game.new(board, player, computer)
game.game_loop
