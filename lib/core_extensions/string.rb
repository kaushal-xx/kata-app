# lib/core_extensions/string.rb
module CoreExtensions
  module String
    refine ::String do
      def add
        return 0 if blank?

        nums = extract_numbers
        negatives = nums.select(&:negative?)

        raise "negative numbers not allowed: #{negatives.join(', ')}" if negatives.any?

        nums.sum
      end

      def extract_numbers
        scan(/-?\d+(?:\.\d+)?/).map do |n|
          n.include?('.') ? n.to_f : n.to_i
        end
      end
    end
  end
end
