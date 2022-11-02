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
end
