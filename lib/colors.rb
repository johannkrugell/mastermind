# frozen_string_literal: true

# module to store the colors to select and return
module Colors
  def colors
    { "1": '🟥', "2": '🟦', "3": '🟨', "4": '🟧', "5": '🟩', "6": '🟪' }
  end

  def display_colors(color_range)
    colors_to_string(color_range)
  end

  def feedback_colors
    { "1": '⬛', "2": '⬜', "3": '❌' }
  end

  private

  def colors_to_string(color_range)
    options = []
    color_range.each { |option, color| options << "#{color}(#{option}) " }
    puts options.join(' ').to_s
  end
end
