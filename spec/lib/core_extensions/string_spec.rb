require 'rails_helper'
require 'core_extensions/string'

RSpec.describe 'String#add' do
  using CoreExtensions::String

  describe '#add' do
    it 'returns 0 for an empty string' do
      expect("".add).to eq(0)
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
      expect{ "$-1*,$2(,3#".add }.to raise_error("negative numbers not allowed: -1")
    end
  end
end
