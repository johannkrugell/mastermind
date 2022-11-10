# frozen_string_literal: true

require './lib/colors'

# helper module to update the terminal and display selections
module Display
  include Colors

  def display_feedback(feedback)
    display_feedback = []
    feedback.each { |selection| display_feedback << feedback_colors[:"#{selection}"] }
    @display_feedback = display_feedback.join(' ').to_s
  end

  def display_guess(guess)
    display = []
    guess.each { |selection| display << colors[:"#{selection}"] }
    @display = display.join(' ').to_s
  end

  def display_round
    puts "#{@player1.name} please select any four colors"
    display_colors(colors)
  end

  def display_winner_message(round_number)
    if check_winner(round_number) && round_number <= '5'
      puts @player1.type == 'breaker' ? 'You won!' : 'I won!'
      player_question(round_number.to_i)
    elsif !check_winner(round_number) && round_number <= '4'
      puts 'Please try again'
    else
      puts @player1.type == 'breaker' ? 'You loose!' : 'I lost?!'
      player_question(round_number.to_i)
    end
  end

  def update_terminal(round)
    puts "\e[H\e[2J"
    title
    display_round
    @guesses.each do |key, _value|
      puts "Guess    #{key.slice(5)}: #{@guesses[key].instance_variable_get(:@display)}"
      puts "Feedback #{key.slice(5)}: #{@guesses[key].instance_variable_get(:@display_feedback)}"
      puts ''
    end
    display_winner_message(round)
  end
end
