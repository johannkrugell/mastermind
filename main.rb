# frozen_string_literal: true

require './lib/game'
require './lib/player'
require './lib/code'
require './lib/guess'

# Start game. Does player want to play?
@game = Game.new(0, 0, 0)
@game.title
@game.want_to_play?

# Create new player object
@game.new_players

# Set code
@code = Code.new(0)
@code.select_code(@game.player1)

# play a round
@game.start_game(@code)
