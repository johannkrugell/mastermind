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

  def breaker_guess(player_type, round_number, guesses)
    player_type == 'coder' ? computer_guess_colors(round_number, guesses) : player_guess_colors
  end

  def breaker_feedback(code)
    compare_guess_to_code(code)
  end

  def invalid_message
    puts 'Please make a valid selection'
    breaker_guess
  end

  private

  def available_colors(color_range, guess)
    available_colors = []
    color_range.transform_keys(&:to_s).each_key do |element|
      available_colors.push(element) unless guess.any?(element)
    end
    available_colors
  end

  def available_positions(feedback)
    available_positions = []
    feedback.each_with_index do |element, index|
      available_positions.push(index) if element != '1'
    end
    available_positions
  end

  def computer_guess_colors(round, guesses)
    round == '1' ? computer_random_guess(4, colors_to_array(colors)) : computer_feedback_guess(round, guesses)
    display_guess(@guess)
  end

  def computer_feedback_guess(round, guesses)
    @guess = []
    prior_feedback(round, guesses)
    prior_guess(round, guesses)
    available_colors = available_colors(colors, @prior_guess)
    available_positions = available_positions(@feedback)
    @feedback.each_with_index do |element, index|
      if element == '3'
        @guess.push(computer_random_guess(1, available_colors).join.to_s)
      else
        @guess.push(@prior_guess[index])
      end
    end
    computer_random_position(available_positions, @feedback, @guess)
  end

  def computer_random_guess(number, available_colors)
    if @guess == 0
      @guess = available_colors.sample(number)
    else
      available_colors.sample(number)
    end
  end

  def computer_random_position(available_positions, feedback, guess)
    new_guess = [9, 9, 9, 9, 9]
    guess.each_with_index do |element, index|
      if feedback[index] == '1'
        new_guess.insert(index, element)
      else
        new_guess.insert(available_positions.sample(1)[0], element)
      end
    end
    new_guess.delete(9)
    @guess = new_guess
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

  def prior_feedback(round, guesses)
    @feedback = guesses[:"guess#{round.to_i - 1}"].instance_variable_get(:@match_color_and_position)
  end

  def prior_guess(round, guesses)
    @prior_guess = guesses[:"guess#{round.to_i - 1}"].instance_variable_get(:@guess)
  end

  def selection_to_array(selection)
    @guess = selection.split(//)
    validate_selection(@guess) == true ? display_guess(@guess) : invalid_message
  end
end
