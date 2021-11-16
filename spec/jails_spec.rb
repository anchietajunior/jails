# frozen_string_literal: true

RSpec.describe Jails do
  describe "#call" do
    class TedController < Jails::Controller
      def think
        "Whoah, man..."
      end
    end

    it "returns a 200 http status code" do
      e = {
        "PATH_INFO" => "/ted/think",
        "QUERY_STRING" => ""
      }

      expect(::Jails::App.new.call(e)[0]).to eq 200
    end
  end
end
