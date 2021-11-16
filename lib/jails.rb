# frozen_string_literal: true

require_relative "jails/version"

module Jails
  class App
    def call(env) # Like proc#call
      [
        200,
        { 'Content-Type' => 'text/html' },
        [ "Hello from Jails!" ]
      ]
    end
  end
end
