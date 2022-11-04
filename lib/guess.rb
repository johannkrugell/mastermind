# frozen_string_literal: true

require './lib/colors'
require './lib/display'
require './lib/validate'

# Create guess object the players guess
class Guess
  include Colors
  include Display
  include Validate
  attr_accessor :guess

  def initialize(guess)
    @guess = guess
  end

  def breaker_guess(player_type)
    player_type == 'coder' ? computer_guess_colors : player_guess_colors
  end

  def breaker_feedback(code)
    compare_guess_to_code(code)
  end

  def invalid_message
    puts 'Please make a valid selection'
    breaker_guess
  end

  private

  def computer_guess_colors
    p 'Computer guess color'
  end

  def compare_guess_to_code(code)
    @match_color_and_position = []
    @guess.to_a.each_with_index do |number, index|
      @match_color_and_position <<
        if guess[index] == code[index]
          '1'
        else
          code.any?(number) ? '2' : '3'
        end
    end
    display_feedback(@match_color_and_position)
  end

  def player_guess_colors
    selection = ''
    selection = gets.chomp until selection.length == 4
    selection_to_array(selection)
  end

  def selection_to_array(selection)
    @guess = selection.split(//)
    validate_selection(@guess) == true ? display_guess(@guess) : invalid_message
  end
end
