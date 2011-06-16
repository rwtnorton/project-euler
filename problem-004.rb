#!/usr/bin/env ruby

#
# A palindromic number reads the same both ways. The largest palindrome
# made from the product of two 2-digit numbers is 9009 = 91 × 99.
#
# Find the largest palindrome made from the product of two 3-digit
# numbers.
#

class String
  def palindrome?
    self == reverse
  end
end

class Numeric
  def palindrome?
    to_s.palindrome?
  end
end

DIGITS = (ARGV[0] || 3).to_i

# Brute force approach: generate all unique combinations (independent
# of tuple order), reverse sort by the sum of the tuple, and
# select the first tuple whose product is a palindrome.
terms = (10**(DIGITS-1) .. (10**DIGITS-1)).to_a
term_pairs = terms.combination(2).to_a + terms.map {|x| [x, x] }
analysis = term_pairs.map  {|x|    [x, x[0] + x[1]] }
                     .sort {|a, b| b[1] <=> a[1] }

analysis.each do |x|
  tuple, sum = x
  product = tuple[0] * tuple[1]
  is_palindrome = product.palindrome?
#p [tuple, sum, product, is_palindrome]
  if is_palindrome
    puts
    puts "#{tuple}: #{product}"
    break
  end
end
