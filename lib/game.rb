# frozen_string_literal: true

require './lib/colors'

# create Game object
class Game
  include Colors
  attr_accessor :round

  def initialize(round)
    @round = round
  end

  def self.title
    puts "
    ▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄
    ██ ▄▀▄ █ ▄▄▀█ ▄▄█▄ ▄█ ▄▄█ ▄▄▀████ ▄▀▄ ██▄██ ▄▄▀█ ▄▀
    ██ █ █ █ ▀▀ █▄▄▀██ ██ ▄▄█ ▀▀▄████ █ █ ██ ▄█ ██ █ █
    ██ ███ █▄██▄█▄▄▄██▄██▄▄▄█▄█▄▄████ ███ █▄▄▄█▄██▄█▄▄█
    ▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀
    "
  end

  def self.want_to_play?
    puts "Do you want to play Master Mind ? (\e[32m y \e[0m/\e[31m n \e[0m)"
    valid_response = %w[y n]
    response = gets.chomp.downcase
    until valid_response.include?(response)
      puts 'Please make valid selection (y/n)'
      response = gets.chomp.downcase
    end
    play_game?(response)
  end

  def self.play_game?(response)
    abort 'Goodbye' if response == 'n'
  end

  def create_player
    @player1 = Player.new('Player1', 'breaker')
    @player1.player_details
    @player2 = Player.new('Computer', 'coder')
  end

  def play_round(game, code)
    @guesses = {}
    round = %w[1 2]
    puts "#{@player1.name} please select any four colors"
    display_colors
    round.each do |round_number|
      game.round = round_number
      @guesses[:"guess#{round_number}"] = Guess.new(0)
      @guesses[:"guess#{round_number}"].breaker_guess
      update_terminal
    end
  end

  def update_terminal
    puts "\e[H\e[2J"
    Game.title
    @guesses.each do |key, _value|
      puts "Guess #{key.slice(5)}: #{@guesses[key].instance_variable_get(:@display).join(' ')}"
    end
  end
end
