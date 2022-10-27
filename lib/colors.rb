# frozen_string_literal: true

# module to store the colors to select and return
module Colors
  def colors
    @colors = { "1": '🔴', "2": '🔵', "3": '🟡', "4": '🟠', "5": '🟢', "6": '🟣' }
  end

  def display_colors
    colors_to_string
  end

  private

  def colors_to_string
    options = []
    colors.each { |option, color| options << "#{option} - #{color}" }
    puts options.join(' ').to_s
  end

  def display_guess(guess)
    @display = []
    guess.each { |selection| @display << colors[:"#{selection}"] }
    @display.join(' ')
  end
end
