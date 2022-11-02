# frozen_string_literal: true

require './lib/colors'
require './lib/display'
require './lib/validate'

# create Game object
class Game
  include Colors
  include Display
  include Validate
  attr_accessor :round

  def initialize(round)
    @round = round
  end

  def title
    puts "
    ▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄
    ██ ▄▀▄ █ ▄▄▀█ ▄▄█▄ ▄█ ▄▄█ ▄▄▀████ ▄▀▄ ██▄██ ▄▄▀█ ▄▀
    ██ █ █ █ ▀▀ █▄▄▀██ ██ ▄▄█ ▀▀▄████ █ █ ██ ▄█ ██ █ █
    ██ ███ █▄██▄█▄▄▄██▄██▄▄▄█▄█▄▄████ ███ █▄▄▄█▄██▄█▄▄█
    ▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀
    "
  end

  def new_players
    create_player
  end

  def start_game(code)
    play_round(code)
  end

  def want_to_play?
    play_response?
  end

  private

  def check_winner(round)
    feedback = @guesses[:"guess#{round}"].instance_variable_get(:@match_color_and_position)
    feedback.all?('1')
  end

  def create_player
    @player1 = Player.new('Player1', 'breaker')
    @player1.player_details
    computer_type = @player1.type == 'coder' ? 'breaker' : 'coder'
    @player2 = Player.new('Computer', computer_type)
  end

  def play_game?(response)
    abort 'Goodbye' if response == 'n'
  end

  def play_response?
    puts "Do you want to play Master Mind ? (\e[32m y \e[0m/\e[31m n \e[0m)"
    response = gets.chomp.downcase
    validate_response(%w[y n], response)
    play_game?(response)
  end

  def play_round(code)
    @guesses = {}
    round = %w[1 2 3 4 5]
    display_round
    round.each do |round_number|
      @guesses[:"guess#{round_number}"] = Guess.new(0)
      @guesses[:"guess#{round_number}"].breaker_guess
      @guesses[:"guess#{round_number}"].breaker_feedback(code.code)
      update_terminal(round_number)
      check_winner(round_number) ? break : next
    end
  end
end
