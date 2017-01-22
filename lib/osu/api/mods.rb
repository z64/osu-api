module Osu
  module API
    module Mods
      # A hashmap of Osu game mods
      MODS = {
        0  => :no_fail,      # 1
        1  => :easy,         # 2
        2  => :no_video,     # 4
        3  => :hidden,       # 8
        4  => :hard_rock,    # 16
        5  => :sudden_death, # 32
        6  => :double_time,  # 64
        7  => :relax,        # 128
        8  => :half_time,    # 256
        9  => :nightcore,    # 512
        10 => :flashlight,   # 1024
        11 => :autoplay,     # 2048
        12 => :spun_out,     # 4096
        13 => :relax2,       # 8192
        14 => :perfect,      # 16384
        16 => :key4,         # 32768
        17 => :key5,         # 65536
        18 => :key6,         # 131072
        19 => :key7,         # 262144
        20 => :key8,         # 524288
        21 => :fade_in,      # 1048576
        22 => :random,       # 2097152
        23 => :last_mod,     # 4194304
        24 => :key9,         # 16777216
        25 => :key10,        # 33554432
        26 => :key1,         # 67108864
        27 => :key3,         # 134217728
        28 => :key2          # 268435456
      }.freeze

      module_function

      # Convert bits from the API into a readable
      # list of the mods applied.
      #
      # @param bits [Integer] mod bits from the api
      # @param stringify [true, false] whether to stringify the symbols
      # @return [Array<Symbol>, Array<String>]
      def mods(bits, stringify = false)
        return :none if bits.zero?

        flags = []

        MODS.each do |position, flag|
          flags << flag if ((bits >> position) & 0x1) == 1
        end

        flags.map! { |s| s.to_s.split('_').map(&:capitalize) * ' ' } if stringify

        flags
      end

      # Convert an array of symbols into bits to be used
      # in filtering API results in a request
      #
      # @param mods [Symbol]
      # @return [Integer]
      def bits(mods_list)
        value = 0

        MODS.each do |position, flag|
          puts "#{position} : #{flag} | #{mods_list.include? flag}"
          value += 2**position if mods_list.include? flag
        end

        value
      end
    end
  end
end
