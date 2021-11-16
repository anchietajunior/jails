# frozen_string_literal: true

require_relative "jails/version"

module Jails
  # This is a simple class to wrap-up the
  # basic structure of a Rack application
  # composed by a http status, a content
  # type hash and an array of strings
  class App
    # like a proc#call
    def call(_env)
      [
        200,
        { "Content-Type" => "text/html" },
        ["Hello from Jails!"]
      ]
    end
  end
end
