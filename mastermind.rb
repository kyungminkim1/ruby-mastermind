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
  @code

  methods:
  -check if secret code is authorised (i.e. 4-digits and only uses numbers 1-6s)
end

class Board
  @secret_code (set)

  methods:
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
