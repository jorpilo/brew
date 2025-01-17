# typed: true
# frozen_string_literal: true

class Array
  # Converts the array to a comma-separated sentence where the last element is
  # joined by the connector word.
  #
  # You can pass the following kwargs to change the default behavior:
  #
  # * <tt>:words_connector</tt> - The sign or word used to join all but the last
  #   element in arrays with three or more elements (default: ", ").
  # * <tt>:last_word_connector</tt> - The sign or word used to join the last element
  #   in arrays with three or more elements (default: ", and ").
  # * <tt>:two_words_connector</tt> - The sign or word used to join the elements
  #   in arrays with two elements (default: " and ").
  #
  # ==== Examples
  #
  #   [].to_sentence                      # => ""
  #   ['one'].to_sentence                 # => "one"
  #   ['one', 'two'].to_sentence          # => "one and two"
  #   ['one', 'two', 'three'].to_sentence # => "one, two, and three"
  #   ['one', 'two'].to_sentence(two_words_connector: '-')
  #   # => "one-two"
  #
  #   ['one', 'two', 'three'].to_sentence(words_connector: ' or ', last_word_connector: ' or at least ')
  #   # => "one or two or at least three"
  # @see https://github.com/rails/rails/blob/v7.0.4.2/activesupport/lib/active_support/core_ext/array/conversions.rb#L8-L84
  #   ActiveSupport Array#to_sentence monkey-patch
  #
  # Copyright (c) David Heinemeier Hansson
  #
  # Permission is hereby granted, free of charge, to any person obtaining
  # a copy of this software and associated documentation files (the
  # "Software"), to deal in the Software without restriction, including
  # without limitation the rights to use, copy, modify, merge, publish,
  # distribute, sublicense, and/or sell copies of the Software, and to
  # permit persons to whom the Software is furnished to do so, subject to
  # the following conditions:
  #
  # The above copyright notice and this permission notice shall be
  # included in all copies or substantial portions of the Software.
  #
  # THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
  # EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
  # MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
  # NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
  # LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
  # OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
  # WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
  def to_sentence(words_connector: ", ", two_words_connector: " and ", last_word_connector: ", and ")
    case length
    when 0
      +""
    when 1
      # This is not typesafe, if the array contains a BasicObject
      +T.unsafe(self[0]).to_s
    when 2
      +"#{self[0]}#{two_words_connector}#{self[1]}"
    else
      +"#{T.must(self[0...-1]).join(words_connector)}#{last_word_connector}#{self[-1]}"
    end
  end
end
