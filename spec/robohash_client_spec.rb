require 'spec_helper'

describe RobohashClient do
  subject { RobohashClient }

  describe '::BASE_URL' do
    it { expect(subject::BASE_URL).to eq 'https://robohash.org' }
  end

  describe '::DEFAULT_DIRECTORY' do
    it { expect(subject::DEFAULT_DIRECTORY).to eq 'robohash_images' }
  end

  describe '::BGSET' do
    it { expect(subject::BGSET).to eq 'bgset=' }
  end

  describe '::SIZE' do
    it { expect(subject::SIZE).to eq 'size=' }
  end

  describe '::SET' do
    it { expect(subject::SET).to eq 'set=' }
  end

  describe '::OPTIONS' do
    it { expect(subject::OPTIONS).to have_key(:set) }
    it { expect(subject::OPTIONS).to have_key(:size) }
    it { expect(subject::OPTIONS).to have_key(:bgset) }
  end

  describe '.get_url' do
    context 'when a valid name is given' do
      let(:valid_name) { 'valid_name' }

      it 'returns the correct URL' do
        method_return = subject.get_url(valid_name)
        expect(method_return).to eq 'https://robohash.org/valid_name'
      end
    end

    context 'when an invalid name is given' do
      let(:invalid_name) { :symbol }

      it 'returns an empty string' do
        method_return = subject.get_url(invalid_name)
        expect(method_return).to eq ''
      end
    end
  end

  describe '.get_many_url' do
    context 'when valid names are given' do
      let(:valid_names) { ['valid1', 'valid2', 'valid3'] }

      it 'returns the corrects URL\'s' do
        method_return = subject.get_many_url(valid_names)
        method_return.each_with_index do |item, index|
          expect(item).to eq "https://robohash.org/valid#{index + 1}"
        end
      end

      it 'returns the correct number of URL\'s' do
        method_return = subject.get_many_url(valid_names)
        expect(method_return.size).to eq valid_names.size
      end
    end

    context 'when valid and invalid names are given' do
      let(:valid_and_invalid_names) { ['valid1', 'valid2', :symbol] }

      it 'returns the correct number of URL\'s' do
        method_return = subject.get_many_url(valid_and_invalid_names)
        expect(method_return.size).to eq valid_and_invalid_names.size - 1
      end
    end

    context 'when no valid names are given' do
      let(:invalid_names) { [Hash.new, 1, :symbol] }

      it 'returns an empty array' do
        method_return = subject.get_many_url(invalid_names)
        expect(method_return).to eq []
      end
    end
  end
end
