# This file is a series of helpers to compose
# querystrings to the osu API
module Osu
  module API

    module_function

    # @return [Hash] user hash part
    def User(data)
      if data.is_a? Integer
        { u: data, type: 'id' }
      elsif data.is_a? String
        { u: data, type: 'string' }
      end
    end

    # @return [Hash] mode hash part
    def Mode(mode)
      { m: MODE.index(mode) }
    end

    # @return [Hash] auth hash part
    def Auth(auth)
      { k: auth }
    end

    # @return [Hash] limit hash part
    def Limit(number)
      { limit: number }
    end
  end
end
