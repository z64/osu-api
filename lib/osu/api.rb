require 'json'
require 'rest-client'

require 'osu/api/constants'
require 'osu/api/hash'
require 'osu/api/get_request'

module Osu
  # Interface to Osu's REST API
  module API
    # Fetches a user object
    class User
      include GetRequest

      def initialize(user, mode = :standard)
        @endpoint = 'get_user'
        @params = API.user(user).merge API.mode(mode)
      end
    end

    class Beatmap
      include GetRequest

      # NOTE: You can make a query with ID, OR author and mode, not all three.
      #       If you specify all three, ID will be ignored by the API
      def initialize(id: nil, set: nil, author: nil, mode: nil, limit: nil)
        @endpoint = 'get_beatmaps'

        @params = {}

        @params.merge! API.beatmap(id) if id
        @params.merge! API.beatmap_set(set) if set
        @params.merge! API.user(author) if author
        @params.merge! API.mode(mode) if mode
        @params.merge! API.limit(limit) if limit
      end
    end
  end
end
