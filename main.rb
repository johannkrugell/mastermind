# frozen_string_literal: true

require './lib/game'
require './lib/player'
require './lib/code'

# Start game. Does player want to play?
Game.title
Game.want_to_play?

# Player wants to play. Create new game and player objects
@game = Game.new(0)
@game.create_player

# Set code
@code = Code.new(0)
@code.code
