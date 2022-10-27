# frozen_string_literal: true

require './lib/colors'

# Create guess object the players guess
class Guess
  include Colors
  attr_accessor :guess

  def initialize(guess)
    @guess = guess
  end

  def invalid_message
    puts 'Please make a valid selection'
    breaker_guess
  end

  def breaker_guess
    selection = ''
    selection = gets.chomp until selection.length == 4
    selection_to_array(selection)
  end

  def selection_to_array(selection)
    @guess = selection.split(//)
    validate_selection(@guess) == true ? display_guess(@guess) : invalid_message
  end

  def validate_selection(guess)
    guess.all? { |number| number.to_i.positive? && number.to_i <= 6 }
  end
end
