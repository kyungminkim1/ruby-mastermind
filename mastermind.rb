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
  @code (can be randomly generated or passed as argument)
end

class Board
  @secret_code (set)

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
  attr_reader :code

  def initialize(code = generate_random_code)
    @code = code.to_s
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

  def initialize
    @role = 'codebreaker'
  end

  def get_code_guess
    guess = gets.chomp.to_s
  end
end
