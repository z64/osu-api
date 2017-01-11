require 'time'

# Data structures to abstract API responses
# into more helpful objects
module Osu
  # An Osu! player
  class User
    # @return [Integer]
    attr_reader :id

    # @return [String]
    attr_reader :name

    # @return [Integer] 300-point hits
    attr_reader :count300

    # @return [Integer] 100-point hits
    attr_reader :count100

    # @return [Integer] 50-point hits
    attr_reader :count50

    # @return [Integer]
    attr_reader :playcount

    # @return [Integer]
    attr_reader :ranked_score

    # @return [Integer]
    attr_reader :total_score

    # @return [Integer]
    attr_reader :pp_rank

    # @return [Float]
    attr_reader :level

    # @return [Float]
    attr_reader :pp_raw

    # @return [Float]
    attr_reader :accuracy

    # A hash of the number of times
    # this User has completed a game
    # with ss, s, or a rank
    # @return [Hash<Symbol, Integer>]
    attr_reader :count_rank

    # @return [String]
    attr_reader :country

    # @return [Integer]
    attr_reader :pp_country_rank

    # @return [Array<Event>] events of this user's profile
    attr_reader :events

    def initialize(data)
      @id = data['user_id'].to_i
      @name = data['username']

      @count300 = data['count300'].to_i
      @count100 = data['count100'].to_i
      @count50 = data['count50'].to_i

      @playcount = data['playcount'].to_i

      @ranked_score = data['ranked_score'].to_i
      @total_score = data['total_score'].to_i

      @pp_rank = data['pp_rank'].to_i
      @level = data['level'].to_f
      @pp_raw = data['pp_raw'].to_f
      @accuracy = data['accuracy'].to_f

      @count_rank = {
        ss: data['count_rank_ss'].to_i,
        s: data['count_rank_s'].to_i,
        a: data['count_rank_a'].to_i
      }

      @country = data['country']
      @pp_country_rank = data['pp_country_rank'].to_i

      @events = data['events'].map { |e| Event.new e }
    end

    # @return [String] url to this users Osu! profile
    def profile_url
      "#{API::BASE_URL}/u/#{id}"
    end
  end

  # An event, which is delivered in the users
  # payload when they score in the top 1000 plays
  # on a beatmap
  class Event
    # @return [String] embedded html code for this event
    attr_reader :display_html

    # @return [Integer]
    attr_reader :beatmap_id

    # @return [Integer]
    attr_reader :beatmapset_id

    # @return [Time]
    attr_reader :date

    # @return [Integer]
    attr_reader :epicfactor

    def initialize(data)
      @display_html = data['display_html']
      @beatmap_id = data['beatmap_id'].to_i
      @beatmapset_id = data['beatmapset_id'].to_i
      @date = Time.parse data['date']
      @epicfactor = data['epicfactor'].to_i
    end
  end

  # An Osu! beatmap
  class Beatmap
  end
end
