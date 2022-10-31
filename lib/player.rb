# frozen_string_literal: true

# create Player object
class Player
  attr_accessor :name, :type

  def initialize(name, type)
    @name = name
    @type = type
  end

  def player_details
    update_player_detail
  end

  private

  def update_player_detail
    puts 'Player 1 please enter your name'
    player_name = gets.chomp
    @name = correct_case(player_name)
    @type = 'breaker'
  end

  def correct_case(string)
    array = string.downcase.split('')
    array[0].upcase.to_s + array[1..array.length].join.to_s
  end
end
