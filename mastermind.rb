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
        @board.guesses_left -= 1
        if matching_digits_found?(codebreakers_guess)
          print_filled_circles(codebreakers_guess)
          print_blank_circles(codebreakers_guess)
        else
          "Not a single clue for you!"
        end
        puts "Guesses left #{@board.guesses_left}"
      end
    end
  end

  private

  def code_is_correct?(code)
    @board.secret_code.digits == code.digits
  end

  def matching_digits_found?(code)
    matches = find_matching_digits(code, true)
    matches.include?(true)
  end

  # returns an array or hash depending on type parameter
  def find_matching_digits(code, type = false)
    matches = []
    potential_matches = {
      secret_digits: [],
      player_digits: []
    }
    for i in 0..code.digits.length - 1
      if @board.secret_code.digits[i] == code.digits[i]
        matches << true
      else
        potential_matches[:secret_digits] << @board.secret_code.digits[i]
        potential_matches[:player_digits] << code.digits[i]
      end
    end
    if type == true
      matches
    else
      potential_matches
    end
  end

  # 'filled circle' = correct number in correct position
  def print_filled_circles(code)
    clues = ''
    matches = find_matching_digits(code)
    matches.each { clues += "\u2b24 " } # unicode for '⬤'
    puts clues
  end

  # 'blank circle' = correct number, but in wrong position
  def print_blank_circles(code)
    clues = ''
    potential_matches = find_matching_digits(code)
    indices = {}
    secret_digits_len = potential_matches[:secret_digits].length - 1
    potential_matches[:player_digits].each do |p_digit|
      (0..secret_digits_len).each do |index|
        if p_digit == potential_matches[:player_digits][index]
          if indices[p_digit] == nil
            indices[p_digit] = [index]
            clues += "\u25ef "  # unicode for '◯'
          elsif !indices[p_digit].include?(index)
            indices[p_digit].append(index)
          end
        end
      end
    end
    puts clues
  end
end
