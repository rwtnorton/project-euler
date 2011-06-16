#!/usr/bin/env ruby

#
# The prime factors of 13195 are 5, 7, 13 and 29.
#
# What is the largest prime factor of the number 600851475143 ?
#

TARGET = (ARGV[0] || 600_851_475_143).to_i

# Finds all primes less than or equal to n.
module Sieve
  class Eratosthenes
    attr_reader :n, :primes

    def initialize(n)
      @n = n

      # Define a workarea for running the sieve.
      # Keeps track of natural numbers disqualified for being prime.
      # If value is false, then the corresponding index is composite.
      # Once the sieve has completed, true values will indicate a prime index.
      workarea = [nil, false] + [true] * (n - 1)
      (2 .. Math.sqrt(n).ceil).each do |i|
        # Skip numbers that have already been disqualified.
        next unless workarea[i]

        # i is prime, so disqualify all its multiples in the table.
        # Be sure to skip over i (via 2*i).
        (2 * i).step(n, i) { |j| workarea[j] = false }
      end

      # Sieve has finished, so map the prime indexes into @primes.
      @primes = (0 .. n).select { |i| workarea[i] }

      # To support prime? method, transform @primes into @primes_map.
      @primes_map = Hash[ @primes.zip([true] * @primes.size) ]
    end

    def prime?(n)
      raise if n > self.n
      return @primes_map[n]
    end
  end
end

# The only factors of interest are prime, so we can limit the search a bit.
UPPER_BOUND = Math.sqrt(TARGET).ceil
Sieve::Eratosthenes.new(UPPER_BOUND).primes.reverse_each do |p|
  # The first multiple is our answer.
  if TARGET % p == 0
    puts p
    break
  end
end
