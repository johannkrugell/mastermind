# frozen_string_literal: true

require './lib/colors'

# class creates the code that needs to be broken object
class Code
  include Colors
  attr_accessor :code

  def initialize(code)
    @code = code
  end

  def select_code
    random_colors
  end

  private

  def random_colors
    color_keys = colors.transform_keys(&:to_s)
    @code = color_keys.keys.sample(4)
  end
end
