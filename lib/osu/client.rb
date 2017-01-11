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

    # @return [User]
    def user(name)
      payload = API::User.new(name).execute(key)
      User.new payload[0] unless payload.empty?
    end

    # @return [Array<Beatmap>] beatmaps matching search criteria
    def beatmap(id, author = nil, mode = nil)
      payload = API::Beatmap.new(
        id: id,
        author: author,
        mode: mode
      ).execute(key)

      payload
    end
  end
end
