# frozen_string_literal: true

# class creates the code that needs to be broken object
class Code
  attr_accessor :code

  def initialize(code)
    @code = code
  end

  def code
    random_colors
  end
  
  private

  def colors
    @colors = ['🔴 ', '🔵 ', '🟡 ', '🟠 ', '🟢 ', '🟣 ']
  end

  def random_colors
    colors
    @colors.sample(4)
  end
end
