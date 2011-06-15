#!/usr/bin/env ruby

#
# Find the sum of all the multiples of 3 or 5 below 1000.
#

UPPER_BOUND = (ARGV[0] || 1000).to_i - 1

puts (1..UPPER_BOUND).select { |n| n % 3 == 0 or n % 5 == 0 }.reduce(:+)
