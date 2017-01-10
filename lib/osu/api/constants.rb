module Osu
  module API
    # Base URL
    BASE_URL = 'https://osu.ppy.sh'.freeze

    # API URL to Osu
    API_URL = "#{BASE_URL}/api".freeze

    # Osu! game modes
    MODE = [
      :standard,
      :taiko,
      :ctb,
      :mania
    ]
  end
end
