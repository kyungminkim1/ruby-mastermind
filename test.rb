require './mastermind.rb'

comp_code = Code.new
puts "Computer's secret code is: #{comp_code.code}"
code = Code.new(1234)
puts puts "Your secret code is: #{code.code}"
