# lib/core_extensions/string.rb
module CoreExtensions
  module String
    refine String do
      def add
        return 0 if strip.empty?
        numbers = strip.extract_numbers

        negatives = numbers.select { |n| n < 0 }
        raise "negative numbers not allowed: #{negatives.join(', ')}" if negatives.any?

        numbers.sum
      end

      def extract_numbers
        scan(/-?\d+(?:\.\d+)?/).map do |n|
          n.include?('.') ? n.to_f : n.to_i
        end
      end
    end
  end
end
