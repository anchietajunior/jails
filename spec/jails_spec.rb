# frozen_string_literal: true

RSpec.describe Jails do
  describe "#call" do
    env = {
      "PATH_INFO" => "/",
      "QUERY_STRING" => ""
    }

    it "returns a 200 http status code" do
      expect(Jails::App.new.call(env)[0]).to eq 200
    end
  end
end
