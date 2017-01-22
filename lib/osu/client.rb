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
    def user(name, mode = :standard)
      raise "Requested user for unknown mode '#{mode}'" unless API::MODE.include? mode
      payload = API::User.new(name, mode).execute(key)
      User.new(payload[0], mode) unless payload.empty?
    end

    # @param id [Integer] beatmap id
    # @param author [String] author name
    # @param mode [Symbol] game mode (see Osu::API::MODE)
    # @param limit [Integer] number of maps to return
    # @return [Beatmap, Array<Beatmap>] beatmaps matching search criteria
    def beatmap(id, author = nil, mode = nil, limit = nil)
      payload = API::Beatmap.new(
        id: id,
        author: author,
        mode: mode,
        limit: limit
      ).execute(key)

      return if payload.empty?

      return Beatmap.new payload[0] if id && author.nil? && mode.nil? && limit.nil?
      payload.map { |e| Beatmap.new e }
    end

    # @param id [Integer] beatmap set id
    # @return [Array<Beatmap>] beatmaps belonging to this set
    def beatmap_set(id)
      payload = API::Beatmap.new(set: id).execute(key)

      maps =  payload.map { |e| Beatmap.new e }
      BeatmapSet.new(maps) unless payload.empty?
    end

    # @param id [Integer] id of the beatmap to get scores for
    # @param user [String, Integer] filter scores by player name or ID
    # @param mode [Symbol] filter scores by game mode (see Osu::API::MODE)
    # @param mods [Integer, Array<Symbol>] mods bits or an array of mods symbols (see Osu::Mods::MODS hashmap)
    # @param limit [Integer] maximum amount of results to return
    def beatmap_score(id, user = nil, mode = nil, mods: nil, limit: nil)
      payload = API::BeatmapScore.new(
        id,
        user: user,
        mode: mode,
        mods: mods,
        limit: limit
      ).execute(key)

      payload.map { |e| Score.new(e) }
    end

    # @param user [String, Integer] filter scores by player name or ID
    # @param mode [Symbol] filter scores by game mode (see Osu::API::MODE)
    # @param limit [Integer] maximum amount of results to return
    def user_best_score(user, mode = nil, limit: nil)
      payload = API::UserBestScore.new(
        user,
        mode,
        limit: limit
      ).execute(key)

      payload.map do |e|
        e['username'] = user if user.is_a? String
        Score.new(e)
      end
    end
  end
end
