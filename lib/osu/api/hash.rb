# This file is a series of helpers to compose
# querystrings to the osu API
module Osu
  module API

    module_function

    # @return [Hash] user hash part
    def user(data)
      if data.is_a? Integer
        { u: data, type: 'id' }
      elsif data.is_a? String
        { u: data, type: 'string' }
      end
    end

    # @return [Hash] beatmap hash part
    def beatmap(id)
      { b: id }
    end

    # @return [Hash] mode hash part
    def mode(mode)
      { m: MODE.index(mode) }
    end

    # @return [Hash] auth hash part
    def auth(auth)
      { k: auth }
    end

    # @return [Hash] limit hash part
    def limit(number)
      { limit: number }
    end
  end
end
