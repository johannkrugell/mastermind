# frozen_string_literal: true

# module to store the colors to select and return
module Colors
  def colors
    { "1": '🟥', "2": '🟦', "3": '🟨', "4": '🟧', "5": '🟩', "6": '🟪' }
  end

  def feedback_colors
    { "1": '⬛', "2": '⬜', "3": '❌' }
  end

  def display_colors(color_range)
    colors_to_string(color_range)
  end

  private

  def colors_to_string(color_range)
    options = []
    color_range.each { |option, color| options << "#{color}(#{option}) " }
    puts options.join(' ').to_s
  end

  def display_guess(guess)
    display = []
    guess.each { |selection| display << colors[:"#{selection}"] }
    @display = display.join(' ').to_s
  end

  def display_feedback(feedback)
    display_feedback = []
    feedback.each { |selection| display_feedback << feedback_colors[:"#{selection}"] }
    @display_feedback = display_feedback.join(' ').to_s
  end
end
