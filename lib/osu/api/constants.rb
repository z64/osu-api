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

    # Approval enum
    APPROVAL = {
      4 => :loved,
      3 => :qualified,
      2 => :approved,
      1 => :ranked,
      0 => :pending,
     -1 => :wip,
     -2 => :graveyard
    }
  end
end
