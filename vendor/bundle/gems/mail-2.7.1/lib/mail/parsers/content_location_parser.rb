# frozen_string_literal: true

require 'mail/utilities'
require 'mail/parser_tools'

module Mail::Parsers
  module ContentLocationParser
    extend Mail::ParserTools

    ContentLocationStruct = Struct.new(:location, :error)

    class << self
      attr_accessor :_trans_keys
      private :_trans_keys, :_trans_keys=
    end
    self._trans_keys = [
      0, 0, 9, 126, 10, 10,
      9, 32, 10, 10, 9,
      32, 1, 244, 10, 10,
      9, 32, 0, 244, 128, 191,
      160, 191, 128, 191, 128,
      159, 144, 191, 128, 191,
      128, 143, 10, 10, 9, 32,
      9, 126, 1, 244, 1,
      244, 10, 10, 9, 32,
      0, 244, 128, 191, 160, 191,
      128, 191, 128, 159, 144,
      191, 128, 191, 128, 143,
      9, 126, 9, 40, 9, 40,
      1, 244, 1, 244, 1,
      244, 1, 244, 9, 126,
      0, 0, 0
    ]

    class << self
      attr_accessor :_key_spans
      private :_key_spans, :_key_spans=
    end
    self._key_spans = [
      0, 118, 1, 24, 1, 24, 244, 1,
      24, 245, 64, 32, 64, 32, 48, 64,
      16, 1, 24, 118, 244, 244, 1, 24,
      245, 64, 32, 64, 32, 48, 64, 16,
      118, 32, 32, 244, 244, 244, 244, 118,
      0
    ]

    class << self
      attr_accessor :_index_offsets
      private :_index_offsets, :_index_offsets=
    end
    self._index_offsets = [
      0, 0, 119, 121, 146, 148, 173, 418,
      420, 445, 691, 756, 789, 854, 887, 936,
      1001, 1018, 1020, 1045, 1164, 1409, 1654, 1656,
      1681, 1927, 1992, 2025, 2090, 2123, 2172, 2237,
      2254, 2373, 2406, 2439, 2684, 2929, 3174, 3419,
      3538
    ]

    class << self
      attr_accessor :_indicies
      private :_indicies, :_indicies=
    end
    self._indicies = [
      0, 1, 1, 1, 2, 1, 1, 1,
      1, 1, 1, 1, 1, 1, 1, 1,
      1, 1, 1, 1, 1, 1, 1, 0,
      3, 4, 3, 3, 3, 3, 3, 5,
      1, 3, 3, 3, 3, 3, 1, 3,
      3, 3, 3, 3, 3, 3, 3, 3,
      3, 1, 1, 1, 3, 1, 1, 1,
      3, 3, 3, 3, 3, 3, 3, 3,
      3, 3, 3, 3, 3, 3, 3, 3,
      3, 3, 3, 3, 3, 3, 3, 3,
      3, 3, 1, 1, 1, 3, 3, 3,
      3, 3, 3, 3, 3, 3, 3, 3,
      3, 3, 3, 3, 3, 3, 3, 3,
      3, 3, 3, 3, 3, 3, 3, 3,
      3, 3, 3, 3, 3, 3, 1, 6,
      1, 0, 1, 1, 1, 1, 1, 1,
      1, 1, 1, 1, 1, 1, 1, 1,
      1, 1, 1, 1, 1, 1, 1, 1,
      0, 1, 7, 1, 8, 1, 1, 1,
      1, 1, 1, 1, 1, 1, 1, 1,
      1, 1, 1, 1, 1, 1, 1, 1,
      1, 1, 1, 8, 1, 9, 9, 9,
      9, 9, 9, 9, 9, 9, 1, 9,
      9, 10, 9, 9, 9, 9, 9, 9,
      9, 9, 9, 9, 9, 9, 9, 9,
      9, 9, 9, 9, 9, 9, 11, 9,
      9, 9, 9, 9, 9, 9, 9, 9,
      9, 9, 9, 9, 9, 9, 9, 9,
      9, 9, 9, 9, 9, 9, 9, 9,
      9, 9, 9, 9, 9, 9, 9, 9,
      9, 9, 9, 9, 9, 9, 9, 9,
      9, 9, 9, 9, 9, 9, 9, 9,
      9, 9, 9, 9, 9, 9, 9, 9,
      12, 9, 9, 9, 9, 9, 9, 9,
      9, 9, 9, 9, 9, 9, 9, 9,
      9, 9, 9, 9, 9, 9, 9, 9,
      9, 9, 9, 9, 9, 9, 9, 9,
      9, 9, 9, 9, 1, 1, 1, 1,
      1, 1, 1, 1, 1, 1, 1, 1,
      1, 1, 1, 1, 1, 1, 1, 1,
      1, 1, 1, 1, 1, 1, 1, 1,
      1, 1, 1, 1, 1, 1, 1, 1,
      1, 1, 1, 1, 1, 1, 1, 1,
      1, 1, 1, 1, 1, 1, 1, 1,
      1, 1, 1, 1, 1, 1, 1, 1,
      1, 1, 1, 1, 1, 1, 13, 13,
      13, 13, 13, 13, 13, 13, 13, 13,
      13, 13, 13, 13, 13, 13, 13, 13,
      13, 13, 13, 13, 13, 13, 13, 13,
      13, 13, 13, 13, 14, 15, 15, 15,
      15, 15, 15, 15, 15, 15, 15, 15,
      15, 16, 15, 15, 17, 18, 18, 18,
      19, 1, 20, 1, 9, 1, 1, 1,
      1, 1, 1, 1, 1, 1, 1, 1,
      1, 1, 1, 1, 1, 1, 1, 1,
      1, 1, 1, 9, 1, 9, 9, 9,
      9, 9, 9, 9, 9, 9, 9, 9,
      9, 9, 9, 9, 9, 9, 9, 9,
      9, 9, 9, 9, 9, 9, 9, 9,
      9, 9, 9, 9, 9, 9, 9, 9,
      9, 9, 9, 9, 9, 9, 9, 9,
      9, 9, 9, 9, 9, 9, 9, 9,
      9, 9, 9, 9, 9, 9, 9, 9,
      9, 9, 9, 9, 9, 9, 9, 9,
      9, 9, 9, 9, 9, 9, 9, 9,
      9, 9, 9, 9, 9, 9, 9, 9,
      9, 9, 9, 9, 9, 9, 9, 9,
      9, 9, 9, 9, 9, 9, 9, 9,
      9, 9, 9, 9, 9, 9, 9, 9,
      9, 9, 9, 9, 9, 9, 9, 9,
      9, 9, 9, 9, 9, 9, 9, 9,
      9, 9, 9, 9, 9, 1, 1, 1,
      1, 1, 1, 1, 1, 1, 1, 1,
      1, 1, 1, 1, 1, 1, 1, 1,
      1, 1, 1, 1, 1, 1, 1, 1,
      1, 1, 1, 1, 1, 1, 1, 1,
      1, 1, 1, 1, 1, 1, 1, 1,
      1, 1, 1, 1, 1, 1, 1, 1,
      1, 1, 1, 1, 1, 1, 1, 1,
      1, 1, 1, 1, 1, 1, 1, 13,
      13, 13, 13, 13, 13, 13, 13, 13,
      13, 13, 13, 13, 13, 13, 13, 13,
      13, 13, 13, 13, 13, 13, 13, 13,
      13, 13, 13, 13, 13, 14, 15, 15,
      15, 15, 15, 15, 15, 15, 15, 15,
      15, 15, 16, 15, 15, 17, 18, 18,
      18, 19, 1, 9, 9, 9, 9, 9,
      9, 9, 9, 9, 9, 9, 9, 9,
      9, 9, 9, 9, 9, 9, 9, 9,
      9, 9, 9, 9, 9, 9, 9, 9,
      9, 9, 9, 9, 9, 9, 9, 9,
      9, 9, 9, 9, 9, 9, 9, 9,
      9, 9, 9, 9, 9, 9, 9, 9,
      9, 9, 9, 9, 9, 9, 9, 9,
      9, 9, 9, 1, 13, 13, 13, 13,
      13, 13, 13, 13, 13, 13, 13, 13,
      13, 13, 13, 13, 13, 13, 13, 13,
      13, 13, 13, 13, 13, 13, 13, 13,
      13, 13, 13, 13, 1, 13, 13, 13,
      13, 13, 13, 13, 13, 13, 13, 13,
      13, 13, 13, 13, 13, 13, 13, 13,
      13, 13, 13, 13, 13, 13, 13, 13,
      13, 13, 13, 13, 13, 13, 13, 13,
      13, 13, 13, 13, 13, 13, 13, 13,
      13, 13, 13, 13, 13, 13, 13, 13,
      13, 13, 13, 13, 13, 13, 13, 13,
      13, 13, 13, 13, 13, 1, 13, 13,
      13, 13, 13, 13, 13, 13, 13, 13,
      13, 13, 13, 13, 13, 13, 13, 13,
      13, 13, 13, 13, 13, 13, 13, 13,
      13, 13, 13, 13, 13, 13, 1, 15,
      15, 15, 15, 15, 15, 15, 15, 15,
      15, 15, 15, 15, 15, 15, 15, 15,
      15, 15, 15, 15, 15, 15, 15, 15,
      15, 15, 15, 15, 15, 15, 15, 15,
      15, 15, 15, 15, 15, 15, 15, 15,
      15, 15, 15, 15, 15, 15, 15, 1,
      15, 15, 15, 15, 15, 15, 15, 15,
      15, 15, 15, 15, 15, 15, 15, 15,
      15, 15, 15, 15, 15, 15, 15, 15,
      15, 15, 15, 15, 15, 15, 15, 15,
      15, 15, 15, 15, 15, 15, 15, 15,
      15, 15, 15, 15, 15, 15, 15, 15,
      15, 15, 15, 15, 15, 15, 15, 15,
      15, 15, 15, 15, 15, 15, 15, 15,
      1, 15, 15, 15, 15, 15, 15, 15,
      15, 15, 15, 15, 15, 15, 15, 15,
      15, 1, 21, 1, 22, 1, 1, 1,
      1, 1, 1, 1, 1, 1, 1, 1,
      1, 1, 1, 1, 1, 1, 1, 1,
      1, 1, 1, 22, 1, 23, 1, 1,
      1, 24, 1, 1, 1, 1, 1, 1,
      1, 1, 1, 1, 1, 1, 1, 1,
      1, 1, 1, 1, 23, 25, 26, 25,
      25, 25, 25, 25, 27, 1, 25, 25,
      25, 25, 25, 1, 25, 25, 25, 25,
      25, 25, 25, 25, 25, 25, 1, 1,
      1, 25, 1, 1, 1, 25, 25, 25,
      25, 25, 25, 25, 25, 25, 25, 25,
      25, 25, 25, 25, 25, 25, 25, 25,
      25, 25, 25, 25, 25, 25, 25, 1,
      1, 1, 25, 25, 25, 25, 25, 25,
      25, 25, 25, 25, 25, 25, 25, 25,
      25, 25, 25, 25, 25, 25, 25, 25,
      25, 25, 25, 25, 25, 25, 25, 25,
      25, 25, 25, 1, 28, 28, 28, 28,
      28, 28, 28, 28, 28, 1, 28, 28,
      29, 28, 28, 28, 28, 28, 28, 28,
      28, 28, 28, 28, 28, 28, 28, 28,
      28, 28, 28, 28, 28, 28, 28, 28,
      28, 28, 28, 30, 31, 28, 28, 28,
      28, 28, 28, 28, 28, 28, 28, 28,
      28, 28, 28, 28, 28, 28, 28, 28,
      28, 28, 28, 28, 28, 28, 28, 28,
      28, 28, 28, 28, 28, 28, 28, 28,
      28, 28, 28, 28, 28, 28, 28, 28,
      28, 28, 28, 28, 28, 28, 28, 32,
      28, 28, 28, 28, 28, 28, 28, 28,
      28, 28, 28, 28, 28, 28, 28, 28,
      28, 28, 28, 28, 28, 28, 28, 28,
      28, 28, 28, 28, 28, 28, 28, 28,
      28, 28, 28, 1, 1, 1, 1, 1,
      1, 1, 1, 1, 1, 1, 1, 1,
      1, 1, 1, 1, 1, 1, 1, 1,
      1, 1, 1, 1, 1, 1, 1, 1,
      1, 1, 1, 1, 1, 1, 1, 1,
      1, 1, 1, 1, 1, 1, 1, 1,
      1, 1, 1, 1, 1, 1, 1, 1,
      1, 1, 1, 1, 1, 1, 1, 1,
      1, 1, 1, 1, 1, 33, 33, 33,
      33, 33, 33, 33, 33, 33, 33, 33,
      33, 33, 33, 33, 33, 33, 33, 33,
      33, 33, 33, 33, 33, 33, 33, 33,
      33, 33, 33, 34, 35, 35, 35, 35,
      35, 35, 35, 35, 35, 35, 35, 35,
      36, 35, 35, 37, 38, 38, 38, 39,
      1, 40, 40, 40, 40, 40, 40, 40,
      40, 40, 1, 40, 40, 41, 40, 40,
      40, 40, 40, 40, 40, 40, 40, 40,
      40, 40, 40, 40, 40, 40, 40, 40,
      40, 40, 40, 40, 40, 40, 40, 40,
      42, 43, 40, 40, 40, 40, 40, 40,
      40, 40, 40, 40, 40, 40, 40, 40,
      40, 40, 40, 40, 40, 40, 40, 40,
      40, 40, 40, 40, 40, 40, 40, 40,
      40, 40, 40, 40, 40, 40, 40, 40,
      40, 40, 40, 40, 40, 40, 40, 40,
      40, 40, 40, 40, 44, 40, 40, 40,
      40, 40, 40, 40, 40, 40, 40, 40,
      40, 40, 40, 40, 40, 40, 40, 40,
      40, 40, 40, 40, 40, 40, 40, 40,
      40, 40, 40, 40, 40, 40, 40, 40,
      1, 1, 1, 1, 1, 1, 1, 1,
      1, 1, 1, 1, 1, 1, 1, 1,
      1, 1, 1, 1, 1, 1, 1, 1,
      1, 1, 1, 1, 1, 1, 1, 1,
      1, 1, 1, 1, 1, 1, 1, 1,
      1, 1, 1, 1, 1, 1, 1, 1,
      1, 1, 1, 1, 1, 1, 1, 1,
      1, 1, 1, 1, 1, 1, 1, 1,
      1, 1, 45, 45, 45, 45, 45, 45,
      45, 45, 45, 45, 45, 45, 45, 45,
      45, 45, 45, 45, 45, 45, 45, 45,
      45, 45, 45, 45, 45, 45, 45, 45,
      46, 47, 47, 47, 47, 47, 47, 47,
      47, 47, 47, 47, 47, 48, 47, 47,
      49, 50, 50, 50, 51, 1, 52, 1,
      40, 1, 1, 1, 1, 1, 1, 1,
      1, 1, 1, 1, 1, 1, 1, 1,
      1, 1, 1, 1, 1, 1, 1, 40,
      1, 40, 40, 40, 40, 40, 40, 40,
      40, 40, 40, 40, 40, 40, 40, 40,
      40, 40, 40, 40, 40, 40, 40, 40,
      40, 40, 40, 40, 40, 40, 40, 40,
      40, 40, 40, 40, 40, 40, 40, 40,
      40, 40, 40, 40, 40, 40, 40, 40,
      40, 40, 40, 40, 40, 40, 40, 40,
      40, 40, 40, 40, 40, 40, 40, 40,
      40, 40, 40, 40, 40, 40, 40, 40,
      40, 40, 40, 40, 40, 40, 40, 40,
      40, 40, 40, 40, 40, 40, 40, 40,
      40, 40, 40, 40, 40, 40, 40, 40,
      40, 40, 40, 40, 40, 40, 40, 40,
      40, 40, 40, 40, 40, 40, 40, 40,
      40, 40, 40, 40, 40, 40, 40, 40,
      40, 40, 40, 40, 40, 40, 40, 40,
      40, 1, 1, 1, 1, 1, 1, 1,
      1, 1, 1, 1, 1, 1, 1, 1,
      1, 1, 1, 1, 1, 1, 1, 1,
      1, 1, 1, 1, 1, 1, 1, 1,
      1, 1, 1, 1, 1, 1, 1, 1,
      1, 1, 1, 1, 1, 1, 1, 1,
      1, 1, 1, 1, 1, 1, 1, 1,
      1, 1, 1, 1, 1, 1, 1, 1,
      1, 1, 1, 45, 45, 45, 45, 45,
      45, 45, 45, 45, 45, 45, 45, 45,
      45, 45, 45, 45, 45, 45, 45, 45,
      45, 45, 45, 45, 45, 45, 45, 45,
      45, 46, 47, 47, 47, 47, 47, 47,
      47, 47, 47, 47, 47, 47, 48, 47,
      47, 49, 50, 50, 50, 51, 1, 40,
      40, 40, 40, 40, 40, 40, 40, 40,
      40, 40, 40, 40, 40, 40, 40, 40,
      40, 40, 40, 40, 40, 40, 40, 40,
      40, 40, 40, 40, 40, 40, 40, 40,
      40, 40, 40, 40, 40, 40, 40, 40,
      40, 40, 40, 40, 40, 40, 40, 40,
      40, 40, 40, 40, 40, 40, 40, 40,
      40, 40, 40, 40, 40, 40, 40, 1,
      45, 45, 45, 45, 45, 45, 45, 45,
      45, 45, 45, 45, 45, 45, 45, 45,
      45, 45, 45, 45, 45, 45, 45, 45,
      45, 45, 45, 45, 45, 45, 45, 45,
      1, 45, 45, 45, 45, 45, 45, 45,
      45, 45, 45, 45, 45, 45, 45, 45,
      45, 45, 45, 45, 45, 45, 45, 45,
      45, 45, 45, 45, 45, 45, 45, 45,
      45, 45, 45, 45, 45, 45, 45, 45,
      45, 45, 45, 45, 45, 45, 45, 45,
      45, 45, 45, 45, 45, 45, 45, 45,
      45, 45, 45, 45, 45, 45, 45, 45,
      45, 1, 45, 45, 45, 45, 45, 45,
      45, 45, 45, 45, 45, 45, 45, 45,
      45, 45, 45, 45, 45, 45, 45, 45,
      45, 45, 45, 45, 45, 45, 45, 45,
      45, 45, 1, 47, 47, 47, 47, 47,
      47, 47, 47, 47, 47, 47, 47, 47,
      47, 47, 47, 47, 47, 47, 47, 47,
      47, 47, 47, 47, 47, 47, 47, 47,
      47, 47, 47, 47, 47, 47, 47, 47,
      47, 47, 47, 47, 47, 47, 47, 47,
      47, 47, 47, 1, 47, 47, 47, 47,
      47, 47, 47, 47, 47, 47, 47, 47,
      47, 47, 47, 47, 47, 47, 47, 47,
      47, 47, 47, 47, 47, 47, 47, 47,
      47, 47, 47, 47, 47, 47, 47, 47,
      47, 47, 47, 47, 47, 47, 47, 47,
      47, 47, 47, 47, 47, 47, 47, 47,
      47, 47, 47, 47, 47, 47, 47, 47,
      47, 47, 47, 47, 1, 47, 47, 47,
      47, 47, 47, 47, 47, 47, 47, 47,
      47, 47, 47, 47, 47, 1, 53, 1,
      1, 1, 54, 1, 1, 1, 1, 1,
      1, 1, 1, 1, 1, 1, 1, 1,
      1, 1, 1, 1, 1, 53, 55, 55,
      55, 55, 55, 55, 55, 56, 1, 55,
      55, 55, 55, 55, 1, 55, 55, 55,
      55, 55, 55, 55, 55, 55, 55, 1,
      1, 1, 55, 1, 1, 1, 55, 55,
      55, 55, 55, 55, 55, 55, 55, 55,
      55, 55, 55, 55, 55, 55, 55, 55,
      55, 55, 55, 55, 55, 55, 55, 55,
      1, 1, 1, 55, 55, 55, 55, 55,
      55, 55, 55, 55, 55, 55, 55, 55,
      55, 55, 55, 55, 55, 55, 55, 55,
      55, 55, 55, 55, 55, 55, 55, 55,
      55, 55, 55, 55, 1, 8, 1, 1,
      1, 57, 1, 1, 1, 1, 1, 1,
      1, 1, 1, 1, 1, 1, 1, 1,
      1, 1, 1, 1, 8, 1, 1, 1,
      1, 1, 1, 1, 58, 1, 59, 1,
      1, 1, 60, 1, 1, 1, 1, 1,
      1, 1, 1, 1, 1, 1, 1, 1,
      1, 1, 1, 1, 1, 59, 1, 1,
      1, 1, 1, 1, 1, 61, 1, 62,
      62, 62, 62, 62, 62, 62, 62, 63,
      1, 62, 62, 64, 62, 62, 62, 62,
      62, 62, 62, 62, 62, 62, 62, 62,
      62, 62, 62, 62, 62, 62, 63, 65,
      66, 65, 65, 65, 65, 65, 67, 62,
      65, 65, 65, 65, 65, 62, 65, 65,
      65, 65, 65, 65, 65, 65, 65, 65,
      62, 62, 62, 65, 62, 62, 62, 65,
      65, 65, 65, 65, 65, 65, 65, 65,
      65, 65, 65, 65, 65, 65, 65, 65,
      65, 65, 65, 65, 65, 65, 65, 65,
      65, 62, 68, 62, 65, 65, 65, 65,
      65, 65, 65, 65, 65, 65, 65, 65,
      65, 65, 65, 65, 65, 65, 65, 65,
      65, 65, 65, 65, 65, 65, 65, 65,
      65, 65, 65, 65, 65, 62, 1, 1,
      1, 1, 1, 1, 1, 1, 1, 1,
      1, 1, 1, 1, 1, 1, 1, 1,
      1, 1, 1, 1, 1, 1, 1, 1,
      1, 1, 1, 1, 1, 1, 1, 1,
      1, 1, 1, 1, 1, 1, 1, 1,
      1, 1, 1, 1, 1, 1, 1, 1,
      1, 1, 1, 1, 1, 1, 1, 1,
      1, 1, 1, 1, 1, 1, 1, 1,
      69, 69, 69, 69, 69, 69, 69, 69,
      69, 69, 69, 69, 69, 69, 69, 69,
      69, 69, 69, 69, 69, 69, 69, 69,
      69, 69, 69, 69, 69, 69, 70, 71,
      71, 71, 71, 71, 71, 71, 71, 71,
      71, 71, 71, 72, 71, 71, 73, 74,
      74, 74, 75, 1, 9, 9, 9, 9,
      9, 9, 9, 9, 22, 1, 9, 9,
      76, 9, 9, 9, 9, 9, 9, 9,
      9, 9, 9, 9, 9, 9, 9, 9,
      9, 9, 9, 22, 9, 11, 9, 9,
      9, 9, 9, 77, 9, 9, 9, 9,
      9, 9, 9, 9, 9, 9, 9, 9,
      9, 9, 9, 9, 9, 9, 9, 9,
      9, 9, 9, 9, 9, 9, 9, 9,
      9, 9, 9, 9, 9, 9, 9, 9,
      9, 9, 9, 9, 9, 9, 9, 9,
      9, 9, 9, 9, 9, 9, 9, 12,
      9, 9, 9, 9, 9, 9, 9, 9,
      9, 9, 9, 9, 9, 9, 9, 9,
      9, 9, 9, 9, 9, 9, 9, 9,
      9, 9, 9, 9, 9, 9, 9, 9,
      9, 9, 9, 1, 1, 1, 1, 1,
      1, 1, 1, 1, 1, 1, 1, 1,
      1, 1, 1, 1, 1, 1, 1, 1,
      1, 1, 1, 1, 1, 1, 1, 1,
      1, 1, 1, 1, 1, 1, 1, 1,
      1, 1, 1, 1, 1, 1, 1, 1,
      1, 1, 1, 1, 1, 1, 1, 1,
      1, 1, 1, 1, 1, 1, 1, 1,
      1, 1, 1, 1, 1, 13, 13, 13,
      13, 13, 13, 13, 13, 13, 13, 13,
      13, 13, 13, 13, 13, 13, 13, 13,
      13, 13, 13, 13, 13, 13, 13, 13,
      13, 13, 13, 14, 15, 15, 15, 15,
      15, 15, 15, 15, 15, 15, 15, 15,
      16, 15, 15, 17, 18, 18, 18, 19,
      1, 9, 9, 9, 9, 9, 9, 9,
      9, 78, 1, 9, 9, 79, 9, 9,
      9, 9, 9, 9, 9, 9, 9, 9,
      9, 9, 9, 9, 9, 9, 9, 9,
      78, 9, 11, 9, 9, 9, 9, 9,
      80, 9, 9, 9, 9, 9, 9, 9,
      9, 9, 9, 9, 9, 9, 9, 9,
      9, 9, 9, 9, 9, 9, 9, 9,
      9, 9, 9, 9, 9, 9, 9, 9,
      9, 9, 9, 9, 9, 9, 9, 9,
      9, 9, 9, 9, 9, 9, 9, 9,
      9, 9, 9, 9, 12, 9, 9, 9,
      9, 9, 9, 9, 9, 9, 9, 9,
      9, 9, 9, 9, 9, 9, 9, 9,
      9, 9, 9, 9, 9, 9, 9, 9,
      9, 9, 9, 9, 9, 9, 9, 9,
      1, 1, 1, 1, 1, 1, 1, 1,
      1, 1, 1, 1, 1, 1, 1, 1,
      1, 1, 1, 1, 1, 1, 1, 1,
      1, 1, 1, 1, 1, 1, 1, 1,
      1, 1, 1, 1, 1, 1, 1, 1,
      1, 1, 1, 1, 1, 1, 1, 1,
      1, 1, 1, 1, 1, 1, 1, 1,
      1, 1, 1, 1, 1, 1, 1, 1,
      1, 1, 13, 13, 13, 13, 13, 13,
      13, 13, 13, 13, 13, 13, 13, 13,
      13, 13, 13, 13, 13, 13, 13, 13,
      13, 13, 13, 13, 13, 13, 13, 13,
      14, 15, 15, 15, 15, 15, 15, 15,
      15, 15, 15, 15, 15, 16, 15, 15,
      17, 18, 18, 18, 19, 1, 9, 9,
      9, 9, 9, 9, 9, 9, 81, 1,
      9, 9, 82, 9, 9, 9, 9, 9,
      9, 9, 9, 9, 9, 9, 9, 9,
      9, 9, 9, 9, 9, 81, 83, 84,
      83, 83, 83, 83, 83, 85, 9, 83,
      83, 83, 83, 83, 9, 83, 83, 83,
      83, 83, 83, 83, 83, 83, 83, 9,
      9, 9, 83, 9, 9, 9, 83, 83,
      83, 83, 83, 83, 83, 83, 83, 83,
      83, 83, 83, 83, 83, 83, 83, 83,
      83, 83, 83, 83, 83, 83, 83, 83,
      9, 12, 9, 83, 83, 83, 83, 83,
      83, 83, 83, 83, 83, 83, 83, 83,
      83, 83, 83, 83, 83, 83, 83, 83,
      83, 83, 83, 83, 83, 83, 83, 83,
      83, 83, 83, 83, 9, 1, 1, 1,
      1, 1, 1, 1, 1, 1, 1, 1,
      1, 1, 1, 1, 1, 1, 1, 1,
      1, 1, 1, 1, 1, 1, 1, 1,
      1, 1, 1, 1, 1, 1, 1, 1,
      1, 1, 1, 1, 1, 1, 1, 1,
      1, 1, 1, 1, 1, 1, 1, 1,
      1, 1, 1, 1, 1, 1, 1, 1,
      1, 1, 1, 1, 1, 1, 1, 13,
      13, 13, 13, 13, 13, 13, 13, 13,
      13, 13, 13, 13, 13, 13, 13, 13,
      13, 13, 13, 13, 13, 13, 13, 13,
      13, 13, 13, 13, 13, 14, 15, 15,
      15, 15, 15, 15, 15, 15, 15, 15,
      15, 15, 16, 15, 15, 17, 18, 18,
      18, 19, 1, 53, 1, 1, 1, 54,
      1, 1, 1, 1, 1, 1, 1, 1,
      1, 1, 1, 1, 1, 1, 1, 1,
      1, 1, 53, 55, 55, 55, 55, 55,
      55, 55, 86, 1, 55, 55, 55, 55,
      55, 1, 55, 55, 55, 55, 55, 55,
      55, 55, 55, 55, 1, 1, 1, 55,
      1, 1, 1, 55, 55, 55, 55, 55,
      55, 55, 55, 55, 55, 55, 55, 55,
      55, 55, 55, 55, 55, 55, 55, 55,
      55, 55, 55, 55, 55, 1, 1, 1,
      55, 55, 55, 55, 55, 55, 55, 55,
      55, 55, 55, 55, 55, 55, 55, 55,
      55, 55, 55, 55, 55, 55, 55, 55,
      55, 55, 55, 55, 55, 55, 55, 55,
      55, 1, 1, 0
    ]

    class << self
      attr_accessor :_trans_targs
      private :_trans_targs, :_trans_targs=
    end
    self._trans_targs = [
      1, 0, 2, 32, 35, 19, 3, 5,
      33, 6, 7, 33, 9, 10, 11, 12,
      13, 14, 15, 16, 8, 18, 36, 1,
      2, 32, 35, 19, 21, 22, 21, 40,
      24, 25, 26, 27, 28, 29, 30, 31,
      21, 22, 21, 40, 24, 25, 26, 27,
      28, 29, 30, 31, 23, 33, 4, 32,
      34, 4, 34, 33, 4, 34, 6, 36,
      17, 38, 39, 37, 9, 10, 11, 12,
      13, 14, 15, 16, 17, 37, 36, 17,
      37, 36, 17, 38, 39, 37, 34
    ]

    class << self
      attr_accessor :_trans_actions
      private :_trans_actions, :_trans_actions=
    end
    self._trans_actions = [
      0, 0, 0, 1, 1, 2, 0, 0,
      0, 0, 0, 3, 0, 0, 0, 0,
      0, 0, 0, 0, 0, 0, 0, 4,
      4, 5, 5, 6, 7, 7, 8, 9,
      7, 7, 7, 7, 7, 7, 7, 7,
      0, 0, 2, 10, 0, 0, 0, 0,
      0, 0, 0, 0, 0, 11, 11, 0,
      12, 0, 2, 4, 4, 6, 13, 14,
      14, 13, 15, 16, 13, 13, 13, 13,
      13, 13, 13, 13, 0, 2, 4, 4,
      6, 11, 11, 0, 3, 12, 17
    ]

    class << self
      attr_accessor :_eof_actions
      private :_eof_actions, :_eof_actions=
    end
    self._eof_actions = [
      0, 0, 0, 0, 0, 0, 0, 0,
      0, 0, 0, 0, 0, 0, 0, 0,
      0, 0, 0, 0, 0, 0, 0, 0,
      0, 0, 0, 0, 0, 0, 0, 0,
      11, 0, 4, 11, 0, 4, 11, 11,
      0
    ]

    class << self
      attr_accessor :start
    end
    self.start = 1
    class << self
      attr_accessor :first_final
    end
    self.first_final = 32
    class << self
      attr_accessor :error
    end
    self.error = 0

    class << self
      attr_accessor :en_comment_tail
    end
    self.en_comment_tail = 20
    class << self
      attr_accessor :en_main
    end
    self.en_main = 1

    def self.parse(data)
      data = data.dup.force_encoding(Encoding::ASCII_8BIT) if data.respond_to?(:force_encoding)

      content_location = ContentLocationStruct.new(nil)
      return content_location if Mail::Utilities.blank?(data)

      # Parser state
      disp_type_s = param_attr_s = param_attr = qstr_s = qstr = param_val_s = nil

      # 5.1 Variables Used by Ragel
      p = 0
      eof = pe = data.length
      stack = []

      begin
        p ||= 0
        pe ||= data.length
        cs = start
        top = 0
      end

      begin
        testEof = false
        _slen, _trans, _keys, _inds, _acts, _nacts = nil
        _goto_level = 0
        _resume = 10
        _eof_trans = 15
        _again = 20
        _test_eof = 30
        _out = 40
        loop do
          if _goto_level <= 0
            if p == pe
              _goto_level = _test_eof
              next
            end
            if cs == 0
              _goto_level = _out
              next
            end
          end
          if _goto_level <= _resume
            _keys = cs << 1
            _inds = _index_offsets[cs]
            _slen = _key_spans[cs]
            _wide = data[p].ord
            _trans = if _slen > 0 &&
                        _trans_keys[_keys] <= _wide &&
                        _wide <= _trans_keys[_keys + 1]
                       _indicies[_inds + _wide - _trans_keys[_keys]]
                     else
                       _indicies[_inds + _slen]
                     end
            cs = _trans_targs[_trans]
            if _trans_actions[_trans] != 0
              case _trans_actions[_trans]
              when 13
                begin
                  qstr_s = p
                end
              when 3
                begin
                  content_location.location = chars(data, qstr_s, p - 1)
                end
              when 1
                begin
                  token_string_s = p
                end
              when 11
                begin
                  content_location.location = chars(data, token_string_s, p - 1)
                end
              when 4
                begin
                end
              when 7
                begin
                end
              when 2
                begin
                  begin
                    stack[top] = cs
                    top += 1
                    cs = 20
                    _goto_level = _again
                    next
                  end
                end
              when 10
                begin
                  begin
                    top -= 1
                    cs = stack[top]
                    _goto_level = _again
                    next
                  end
                end
              when 15
                begin
                  qstr_s = p
                end
                begin
                  content_location.location = chars(data, qstr_s, p - 1)
                end
              when 14
                begin
                  qstr_s = p
                end
                begin
                  content_location.location = chars(data, token_string_s, p - 1)
                end
              when 12
                begin
                  content_location.location = chars(data, token_string_s, p - 1)
                end
                begin
                  begin
                    stack[top] = cs
                    top += 1
                    cs = 20
                    _goto_level = _again
                    next
                  end
                end
              when 5
                begin
                end
                begin
                  token_string_s = p
                end
              when 6
                begin
                end
                begin
                  begin
                    stack[top] = cs
                    top += 1
                    cs = 20
                    _goto_level = _again
                    next
                  end
                end
              when 8
                begin
                end
                begin
                  begin
                    stack[top] = cs
                    top += 1
                    cs = 20
                    _goto_level = _again
                    next
                  end
                end
              when 9
                begin
                end
                begin
                  begin
                    top -= 1
                    cs = stack[top]
                    _goto_level = _again
                    next
                  end
                end
              when 17
                begin
                  begin
                    stack[top] = cs
                    top += 1
                    cs = 20
                    _goto_level = _again
                    next
                  end
                end
                begin
                  content_location.location = chars(data, token_string_s, p - 1)
                end
              when 16
                begin
                  qstr_s = p
                end
                begin
                  content_location.location = chars(data, token_string_s, p - 1)
                end
                begin
                  begin
                    stack[top] = cs
                    top += 1
                    cs = 20
                    _goto_level = _again
                    next
                  end
                end
              end
            end
          end
          if _goto_level <= _again
            if cs == 0
              _goto_level = _out
              next
            end
            p += 1
            if p != pe
              _goto_level = _resume
              next
            end
          end
          if _goto_level <= _test_eof
            if p == eof
              case _eof_actions[cs]
              when 11
                begin
                  content_location.location = chars(data, token_string_s, p - 1)
                end
              when 4
                begin
                end
              end
            end
          end
          break if _goto_level <= _out
        end
      end

      raise Mail::Field::IncompleteParseError.new(Mail::ContentLocationElement, data, p) if p != eof || cs < 32

      content_location
    end
  end
end
