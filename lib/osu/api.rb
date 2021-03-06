require 'json'
require 'rest-client'

require 'osu/api/constants'
require 'osu/api/hash'
require 'osu/api/get_request'
require 'osu/api/mods.rb'

module Osu
  # Interface to Osu's REST API
  module API
    # Fetches a user object
    class User
      include GetRequest

      def initialize(user, mode = :standard, event_days: nil)
        @endpoint = 'get_user'

        @params = {}

        @params.merge! API.user(user)
        @params.merge! API.mode(mode)
        @params.merge! API.event_days(event_days) if event_days
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

    class BeatmapScore
      include GetRequest

      def initialize(id, user: nil, mode: nil, mods: nil, limit: nil)
        @endpoint = 'get_scores'

        @params = {}

        @params.merge! API.beatmap(id) if id
        @params.merge! API.user(user) if user
        @params.merge! API.mode(mode) if mode
        if mods
          mods = API::Mods.bits(mods) if mods.is_a? Array
          @params.merge! API.mods(mods)
        end
        @params.merge! API.limit(limit) if limit
      end
    end

    module UserScore
      def initialize(user, mode = :standard, limit: nil)
        @params = {}

        @params.merge! API.user(user) if user
        @params.merge! API.mode(mode) if mode
        @params.merge! API.limit(limit) if limit
      end
    end

    class UserBestScore
      include GetRequest
      include UserScore

      def endpoint
        @endpoint = 'get_user_best'
      end
    end

    class UserRecentScore
      include GetRequest
      include UserScore

      def endpoint
        @endpoint = 'get_user_recent'
      end
    end
  end
end
