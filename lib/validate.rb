# frozen_string_literal: true

# Helper module to validate the user input
module Validate
  def validate_response(valid_responses, response)
    valid_response = valid_responses
    until valid_responses.include?(response)
      puts 'Please make valid selection ' \
           "(\e[32m #{valid_response[0]} \e[0m/\e[31m #{valid_response[1]} \e[0m)"
      response = gets.chomp.downcase
    end
    response
  end

  def validate_selection(player_selection)
    player_selection.all? { |number| number.to_i.positive? && number.to_i <= 6 }
  end
end
