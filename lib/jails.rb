# frozen_string_literal: true

require_relative "jails/version"
require_relative "file_model"

# This is the main module of this application
# where the App and Controller classes
# are created.
module Jails
  def self.to_underscore(str)
    str.gsub(
      /([A-Z+])([A-Z][a-z])/,
      '\1_\2'
    ).gsub(
      /([a-z\d])([A-Z])/,
      '\1_\2'
    ).downcase
  end

  # Here we are oppening the Object class and
  # implementing a way to require our controllers
  # without require or require_relative specifind
  # the controllers names
  class Object
    def self.const_missing(con)
      require Jails.to_underscore(con.to_s)
      Object.const_get(con)
    end
  end

  # This is a simple class to wrap-up the
  # basic structure of a Rack application
  # composed by a http status, a content
  # type hash and an array of strings
  class App
    def cont_and_act(env)
      _, con, act, _after = env["PATH_INFO"].split("/")
      con = "#{con.capitalize}Controller"
      [Object.const_get(con), act]
    end

    # like a proc#call
    def call(env)
      kl, act = cont_and_act(env)
      text = kl.new(env).send(act)
      [
        200,
        { "Content-Type" => "text/html" },
        [text]
      ]
    end
  end

  require "erb"

  # Creating a new Controller class to handle
  # requests with some metaprogramming
  class Controller
    attr_reader :env

    def initialize(env)
      @env = env
    end

    def request
      @request ||= Rack::Request.new @env
    end

    def params
      request.params
    end

    def render(name, bin = binding())
      template = "app/views/#{name}.html.erb"
      e = ERB.new(File.read(template))
      e.result(bin)
    end
  end
end
