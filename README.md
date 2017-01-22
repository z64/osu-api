# Osu::Api

REST API binding for [Osu!](https://osu.ppy.sh/)

See [here](https://github.com/ppy/osu-api/wiki) for more details on the API.

Created for [ccr](https://github.com/z64/ccr)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'osu-api', github: 'https://github.com/z64/osu-api'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install osu-api

## Usage

For full documentation, see [here](http://www.rubydoc.info/github/z64/osu-api)

Basic usage examples:

```ruby
OSU = Osu::Client.new 'my-secret-token'

# User stats can be requested by name (string) or ID (integer)
OSU.user 'skudfuddle' #=> User
OSU.user 4789534      #=> User

# You can request user stats for different game modules
# (the default is :standard)
OSU.user 'skudfuddle', :mania # also :taiko, :ctb, :standard

# Beatmaps must be fetched by ID
OSU.beatmap 1112761   #=> Beatmap

# You can search for beatmaps by passing nil for ID
# followed by a few search terms
OSU.beatmap nil, author: 'Monstrata', mode: :standard, limit: 5
# The above searches for the first 5 maps by Monstrata
# that are mapped for standard

# Get top beatmap scores
OSU.beatmap_score 1112761 #=> Array<Score>

# Filter top beatmap scores by some criteria
OSU.beatmap_score 1112761, user: 'Dagresha' #=> Array<Score>
OSU.beatmap_score 1112761, mode: :ctb       #=> Array<Score>

# Get a user's top 3 best standard scores
OSU.user_score 'skudfuddle', limit: 3 #=> Array<Score>

# Get a user's top 3 best taiko scores
OSU.user_score 4789534, mode: :taiko, limit: 3 #=> Array<Score>

# Get a user's most recent scores
OSU.user_score 'skudfuddle', :recent
```

## Support

Open an issue, or preferably, contact me on Discord - I'm `Lune#2639`
