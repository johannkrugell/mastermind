# frozen_string_literal: true

require './lib/colors'
require './lib/display'
require './lib/validate'

# create Game object
class Game
  include Colors
  include Display
  include Validate
  attr_accessor :round, :player1, :player2

  def initialize(round, player1, player2)
    @round = round
    @player1 = player1
    @player2 = player2
  end

  def new_players
    create_player
  end

  def start_game(code_to_break)
    play_round(code_to_break)
  end

  def restart_game
    @game = Game.new(0, 0, 0)
    @game.title
    @game.new_players
    @code = Code.new(0)
    @code.select_code(@game.player1)
    @game.start_game(@code)
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

  def want_to_play?
    player_question(@round)
  end

  private

  def check_winner(round_number)
    feedback = @guesses[:"guess#{round_number}"].instance_variable_get(:@match_color_and_position)
    feedback.all?('1')
  end

  def create_player
    self.player1 = Player.new('Player1', 'breaker')
    player1.player_details
    computer_type = @player1.type == 'coder' ? 'breaker' : 'coder'
    self.player2 = Player.new('Computer', computer_type)
  end

  def play_game?(player_response, round_number)
    abort 'Goodbye' if player_response == 'n'
    restart_game if round_number.positive?
  end

  def player_response?(round_number)
    response = gets.chomp.downcase
    validate_response(%w[y n], response)
    play_game?(response, round_number)
  end

  def play_round(code_to_break)
    @guesses = {}
    round = %w[1 2 3 4 5]
    display_round
    round.each do |round_number|
      @guesses[:"guess#{round_number}"] = Guess.new(0)
      @guesses[:"guess#{round_number}"].breaker_guess(player1.type, round_number, @guesses)
      @guesses[:"guess#{round_number}"].breaker_feedback(code_to_break.code)
      update_terminal(round_number)
      check_winner(round_number) ? break : next
    end
  end

  def player_question(round_number)
    if round_number.zero?
      puts "Do you want to play Master Mind ? (\e[32m y \e[0m/\e[31m n \e[0m)"
    else
      puts "Would you like to play again ? (\e[32m y \e[0m/\e[31m n \e[0m)"
    end
    player_response?(round_number)
  end
end
