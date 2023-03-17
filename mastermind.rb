=begin

Recreate a game of Mastermind using Ruby

Rough outline of code architecture below

class Player

  methods (when codebreaker):
  -accept an input
  methods (when codemaker):
  -accept an input
end

class Computer

  methods (when codebreaker):
  -guess digits used in secret code
  -guess digit combination

  methods (when codemaker):
  -generate random 4-digit code using numbers 1-6
end

class Code
  @digits (can be randomly generated or passed as argument)
end

class Board
  @secret_code (set)
  @max_guesses
  @guesses_left

  methods:
  -check if secret code is allowed (i.e. 4-digits and only uses numbers 1-6s)
  -check if codebreaker's guess has digit(s) matching secret code
  -check if digit(s) are in correct spot
  -check if code is correct
end

class Game (manages game state)
  @board
  @codebreaker
  @codemaker

  methods:
  -announce victory (from player point of view)
  -announce loss (from player point of view)
  -set player's role
  -set computer's role
end

=end

class Code
  attr_reader :digits

  def initialize(digits = generate_random_code)
    @digits = digits.to_s
  end

  private

  def generate_random_code
    random_code = ''
    while random_code.length < 4
      random_code += rand(1..6).to_s
    end
    random_code
  end
end

class Computer
  attr_reader :role

  def initialize
    @role = 'codemaker'
  end

  def create_secret_code
    secret_code = Code.new
  end
end

class Player
  attr_reader :role

  def initialize
    @role = 'codebreaker'
  end

  def get_input
    input = Code.new(gets.chomp)
  end
end

class Board
  attr_reader :secret_code, :max_guesses
  attr_accessor :guesses_left

  def initialize
    @secret_code = nil
    @max_guesses = 12
    @guesses_left = 12
  end

  def set_secret_code(code)
    if code.digits.match(/[1-6][1-6][1-6][1-6]/)
      @secret_code = code
    else
      puts 'Your code is invalid! Please provide a 4-digit code using numbers between 1-6.'
    end
  end
end

class Game
  def initialize(board, player, computer)
    @board = board
    @player = player
    @computer = computer
  end

  def game_loop
    while @board.guesses_left.positive?
      puts 'Guess the 4-digit secret code'
      codebreakers_guess = @player.get_input
      if code_is_correct?(codebreakers_guess)
        puts 'Your guess is correct!'
        break
      else
        if matching_digits_found?(codebreakers_guess)
          puts 'Code incorrect, but some right number(s) in the right spot'
        end
        @board.guesses_left -= 1
        puts "Wrong answer! Guesses left #{@board.guesses_left}"
      end
    end
  end

  private

  def code_is_correct?(code)
    @board.secret_code.digits == code.digits
  end

  def matching_digits_found?(code)
    matches = Array.new(code.digits.length)
    clues = ''
    for i in 0..matches.length - 1
      if @board.secret_code.digits[i] == code.digits[i]
        matches[i] = true
        clues += "\u2b24 " # unicode for '⬤'
      end
    end
    puts clues
    matches.include?(true)
  end
end
