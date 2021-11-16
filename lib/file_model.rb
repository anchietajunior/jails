# frozen_string_literal: true

# Now is time to create
# some models
class FileModel
  require "json"

  def initialize(fnd)
    @fn = fnd
    cont = File.read fnd
    @hash = JSON.parse cont
  end

  def [](field)
    @hash[field.to_s]
  end

  def self.find(id)
    new "data/#{id}.json"
  rescue StandardError => e
    puts e
    nil
  end
end
