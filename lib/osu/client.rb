require 'osu/api'
require 'osu/data'

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
      request = API::User.new(name)
      User.new request.execute(key)[0]
    end
  end
end
