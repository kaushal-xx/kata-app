require 'rails_helper'
require 'core_extensions/string'

RSpec.describe 'String#add' do
  using CoreExtensions::String

  describe '#add' do
    it 'returns 0 for an empty string' do
      expect("".add).to eq(0)
      expect("   ".add).to eq(0)
    end

    it 'returns the number itself for a single number' do
      expect("1".add).to eq(1)
    end

    it 'returns the sum for two numbers' do
      expect("1,2".add).to eq(3)
    end

    it 'returns the sum for multiple comma-separated numbers' do
      expect("1,2,3,4".add).to eq(10)
    end

    it 'handles newline characters as delimiters' do
      expect("1\n2,3".add).to eq(6)
    end

    it 'supports a custom delimiter' do
      expect("//;\n1;2".add).to eq(3)
    end

    it 'raises an error for a single negative number' do
      expect { "1,-2,3".add }.to raise_error("negative numbers not allowed: -2")
    end

    it 'raises an error for multiple negative numbers' do
      expect { "1,-2,-3,4".add }.to raise_error("negative numbers not allowed: -2, -3")
    end

    it 'ignores whitespace before and after the input string' do
      expect("   1,2,3   ".add).to eq(6)
    end

    it 'ignores special character before and after the input string' do
      expect("$1*,$2(,3#".add).to eq(6)
    end

    it 'raises an error for negative numbers with special character' do
      expect { "$-1*,$2(,3#".add }.to raise_error("negative numbers not allowed: -1")
    end

    it 'raises NoMethodError when called on Integer' do
      expect { 123.add }.to raise_error(NoMethodError, /undefined method 'add' for an instance of Integer/)
    end

    it 'raises NoMethodError when called on nil' do
      expect { 1.2.add }.to raise_error(NoMethodError, /undefined method 'add' for an instance of Float/)
    end

    it 'does not raise error when called on a String' do
      expect { "1,2,3".add }.not_to raise_error
    end
  end

  describe '#extract_numbers' do
    it 'extracts integers from a string' do
      expect("abc123xyz456".extract_numbers).to eq([ 123, 456 ])
    end

    it 'extracts floats from a string' do
      expect("price: 12.5, tax: 2.5".extract_numbers).to eq([ 12.5, 2.5 ])
    end

    it 'handles negative numbers' do
      expect("profit: -40, loss: -3.5".extract_numbers).to eq([ -40, -3.5 ])
    end

    it 'returns empty array if no numbers exist' do
      expect("nothing here!".extract_numbers).to eq([])
    end

    it 'mixes integers and floats' do
      expect("a1 b2.5 c3".extract_numbers).to eq([ 1, 2.5, 3 ])
    end

    it 'ignores non-numeric characters' do
      expect("$20.5 + @3 and -1.1!".extract_numbers).to eq([ 20.5, 3, -1.1 ])
    end

    it 'raises an error for invalid data type' do
      expect("$20.5 + @3 and -1.1!".extract_numbers).to eq([ 20.5, 3, -1.1 ])
    end

    it 'raises NoMethodError when called on Integer' do
      expect { 123.extract_numbers }.to raise_error(NoMethodError, /undefined method 'extract_numbers' for an instance of Integer/)
    end

    it 'raises NoMethodError when called on nil' do
      expect { 1.3.extract_numbers }.to raise_error(NoMethodError, /undefined method 'extract_numbers' for an instance of Float/)
    end

    it 'raises NoMethodError when called on Array' do
      expect { [ 1, 2, 3 ].extract_numbers }.to raise_error(NoMethodError, /undefined method 'extract_numbers' for an instance of Array/)
    end

    it 'works correctly when called on a String' do
      expect("value 12 and -3.5".extract_numbers).to eq([ 12, -3.5 ])
    end
  end
end
