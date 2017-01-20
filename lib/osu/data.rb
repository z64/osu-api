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

    # @return [Symbol] game mode this users stats belong to
    attr_reader :mode

    def initialize(data, mode)
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

      @mode = mode
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
    # @return [Integer]
    attr_reader :set_id

    # @return [Integer]
    attr_reader :id

    # @return [Symbol] approval status of this map (see API::APPROVAL)
    attr_reader :approval

    # @return [Integer]
    attr_reader :total_length

    # @return [Integer]
    attr_reader :hit_length

    # @return [String]
    attr_reader :version

    # @return [String]
    attr_reader :md5

    # @return [Hash<Symbol, Integer>]
    attr_reader :difficulty

    # @return [Symbol]
    attr_reader :mode

    # @return [Time]
    attr_reader :approved_date

    # @return [Time]
    attr_reader :last_update

    # @return [String]
    attr_reader :artist

    # @return [String]
    attr_reader :title

    # @return [String]
    attr_reader :creator

    # @return [Integer]
    attr_reader :bpm

    # @return [String]
    attr_reader :source

    # @return [Array<String>]
    attr_reader :tags

    # @return [Integer]
    attr_reader :genre_id

    # @return [Integer]
    attr_reader :language_id

    # @return [Integer]
    attr_reader :favourite_count

    # @return [Integer]
    attr_reader :play_count

    # @return [Integer]
    attr_reader :pass_count

    # @return [Integer]
    attr_reader :max_combo

    def initialize(data)
      @set_id = data['beatmapset_id'].to_i
      @id = data['beatmap_id'].to_i

      @approval = API::APPROVAL.fetch data['approved'].to_i

      @total_length = data['total_length'].to_i
      @hit_length = data['hit_length'].to_i

      @version = data['version']

      @md5 = data['file_md5']

      @difficulty = {
        size: data['diff_size'].to_i,
        overall: data['diff_overall'].to_i,
        approach: data['diff_approach'].to_i,
        drain: data['diff_drain'].to_i,
        rating: data['difficultyrating'].to_f
      }

      @mode = API::MODE.at data['mode'].to_i

      @approved_date = Time.parse data['approved_date'] unless data['approved_date'].nil?
      @last_update = Time.parse data['last_update']

      @artist = data['artist']
      @title = data['title']
      @creator = data['creator']

      @bpm = data['bpm'].to_i

      @source = data['source']
      @tags = data['tags'].split(' ')

      @genre_id = data['genre_id'].to_i
      @language_id = data['language_id'].to_i

      @favourite_count = data['favourite_count'].to_i
      @play_count = data['playcount'].to_i
      @pass_count = data['passcount'].to_i

      @max_combo = data['max_combo'].to_i
    end

    # @return [String] url to this beatmap's profile
    def url
      "#{API::BASE_URL}/b/#{id}"
    end

    # # @return [String] url to download this beatmap
    # def download_url
    #   "#{API::BASE_URL}/d/#{id}"
    # end

    # @return [true, false] whether this map is approved
    def approved?
      API::APPROVAL.key(@approval) > 0
    end
  end

  # A collection of Beatmaps
  class BeatmapSet
    # @return [Array<Beatmap>] the beatmaps contained in this set
    attr_reader :beatmaps
    alias maps beatmaps

    # @return [Integer] beatmap set ID
    attr_reader :id

    # @return [Symbol] approval status of this map (see API::APPROVAL)
    attr_reader :approval

    # @return [String]
    attr_reader :artist

    # @return [String]
    attr_reader :title

    # @return [String]
    attr_reader :creator

    # @return [String]
    attr_reader :source

    def initialize(beatmaps)
      raise 'Must supply Array<Beatmap> with at least one element' unless beatmaps.is_a?(Array) && beatmaps.first.is_a?(Beatmap)
      @beatmaps = beatmaps

      map = beatmaps.first

      @id = map.set_id

      @approval = map.approval

      @artist = map.artist

      @title = map.title

      @creator = map.creator

      @source = map.source
    end

    # @return [String] url to this beatmap set's profile
    def url
      "#{API::BASE_URL}/s/#{id}"
    end
  end
end
