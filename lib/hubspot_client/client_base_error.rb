# frozen_string_literal: true

class ClientBaseError < StandardError
  def initialize(response)
    error_message = { status: response.code, body: response.body }
    super(error_message)
  end
end
