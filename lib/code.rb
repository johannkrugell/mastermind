# frozen_string_literal: true

require './lib/colors'
require './lib/validate'

# class creates the code that needs to be broken object
class Code
  include Colors
  include Validate
  attr_accessor :code

  def initialize(code)
    @code = code
  end

  def select_code(player)
    player.type == 'breaker' ? computer_set_code : player_set_code(player)
  end

  private

  def computer_set_code
    @code = colors.transform_keys(&:to_s).keys.sample(4)
  end

  def player_set_code(player)
    puts "#{player.name} please set code using colors below"
    display_colors(colors)
    @code = gets.chomp.split(//)
    validate_selection(@code)
  end
end
