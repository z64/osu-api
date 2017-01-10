require 'json'
require 'rest-client'

module Osu
  # Interface to Osu's REST API
  module API
    API_URL = 'https://osu.ppy.sh/api'.freeze

    # Structure of a GET request to the API
    module GetRequest
      # @return [String] endpoint to query
      attr_reader :endpoint

      # @return [Hash] parameters to pass as a querystring
      attr_reader :params

      # Compose a request URL from API_URL
      # and endpoint
      def url
        "#{API_URL}/#{endpoint}"
      end

      # Executes the request set up by the instance
      # of whatever implements GetRequest
      def execute(key)
        params.merge!({ k: key })

        response = RestClient.get url, params: params
        JSON.parse response
      end
    end
  end
end
