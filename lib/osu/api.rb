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

      def initialize(user)
        @endpoint = 'get_user'
        @params = API::User user
      end
    end
  end
end
