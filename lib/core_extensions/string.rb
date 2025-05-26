# lib/core_extensions/string.rb
module CoreExtensions
  module String
    refine String do
      def add
        return 0 if strip.empty?

        delimiter = /,|\n/
        input = dup

        if input.start_with?("//")
          delimiter_line, input = input.split("\n", 2)
          custom_delimiter = delimiter_line[2..]
          delimiter = Regexp.escape(custom_delimiter)
        end

        numbers = input.split(/#{delimiter}/).map(&:to_i)

        negatives = numbers.select { |n| n < 0 }
        raise "negative numbers not allowed: #{negatives.join(', ')}" if negatives.any?

        numbers.sum
      end
    end
  end
end
