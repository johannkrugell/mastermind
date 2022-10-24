# frozen_string_literal: true

# create Player object
class Player
  attr_accessor :name, :type

  def initialize(name, type)
    @name = name
    @type = type
  end

  def player_details
    puts 'Player 1 please enter your name'
    response = gets.chomp
    @name = correct_case(response)
    @type = 'breaker'
  end

  def correct_case(response)
    array = response.downcase.split('')
    array[0].upcase.to_s + array[1..array.length].join.to_s
  end
end
