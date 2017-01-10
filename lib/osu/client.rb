require 'osu/api'

module Osu
  # Client interface that caches a token to make
  # subsequent requests with
  class Client
    # @return [String] auth key
    attr_reader :key

    def initialize(key)
      @key = key
    end

    def user(name)
      API::User.new(name).execute key
    end
  end
end
