# Osu::Api

Ruby REST API bindings for [osu!](https://osu.ppy.sh/)

## Resources

* [API Reference](https://github.com/ppy/osu-api/wiki)
* [Documentation](https://www.rubydoc.info/github/z64/osu-api)

## Installation

* Install bundler via Ruby gems:

```bash
$ gem install bundler
```
    
* Create file named `Gemfile` in your project root folder

* Add this lines to your application's Gemfile:

```ruby
source 'https://rubygems.org'
gem 'osu-api', git: 'https://github.com/z64/osu-api.git'
```

* And then execute:

```bash
$ bundle update
```

## Usage

Basic usage examples:

```ruby
osu = Osu::Client.new 'api-key'

# User stats can be requested by name (string) or ID (integer)
osu.user 'skudfuddle' #=> User
osu.user 4789534      #=> User

# You can request user stats for different game modules
# (the default is :standard)
osu.user 'skudfuddle', :mania # also :taiko, :ctb, :standard

# Beatmaps must be fetched by ID
osu.beatmap 1112761   #=> Beatmap

# You can search for beatmaps by passing nil for ID
# followed by a few search terms
osu.beatmap nil, author: 'Monstrata', mode: :standard, limit: 5
# The above searches for the first 5 maps by Monstrata
# that are mapped for standard

# Get top beatmap scores
osu.beatmap_score 1112761 #=> Array<Score>

# Filter top beatmap scores by some criteria
osu.beatmap_score 1112761, user: 'Dagresha' #=> Array<Score>
osu.beatmap_score 1112761, mode: :ctb       #=> Array<Score>

# Get a user's top 3 best standard scores
osu.user_score 'skudfuddle', limit: 3 #=> Array<Score>

# Get a user's top 3 best taiko scores
osu.user_score 4789534, mode: :taiko, limit: 3 #=> Array<Score>

# Get a user's most recent scores
osu.user_score 'skudfuddle', :recent
```

## Support

Open an issue, or preferably, contact me on Discord - I'm `Lune#2639`
