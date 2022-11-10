# frozen_string_literal: true

require './lib/validate'

# create Player object
class Player
  include Validate
  attr_accessor :name, :type

  def initialize(name, type)
    @name = name
    @type = type
  end

  def player_details
    update_player_name
    update_player_type
  end

  private

  def update_player_name
    puts 'Player 1 please enter your name'
    player_name = gets.chomp
    @name = correct_case(player_name)
  end

  def update_player_type
    puts "#{@name}, would you like to be the coder or breaker (\e[32m c \e[0m/\e[31m b \e[0m)?"
    player_type = gets.chomp
    player_type = validate_response(%w[c b], player_type)
    @type = player_type == 'c' ? 'coder' : 'breaker'
  end

  def correct_case(string)
    array = string.downcase.split('')
    array[0].upcase.to_s + array[1..array.length].join.to_s
  end
end
