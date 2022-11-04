# frozen_string_literal: true

# Helper module to validate the user input
module Validate
  def validate_response(valid_responses, response)
    valid_response = valid_responses
    until valid_response.include?(response)
      puts 'Please make valid selection (y/n)'
      response = gets.chomp.downcase
    end
  end

  def validate_selection(selection)
    selection.all? { |number| number.to_i.positive? && number.to_i <= 6 }
  end
end
