# frozen_string_literal: true

# create Game object
class Game
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
end
