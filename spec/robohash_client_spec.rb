require 'spec_helper'

describe RobohashClient do
  subject { RobohashClient }

  describe '::BASE_URL' do
    it { expect(subject::BASE_URL).to eq 'https://robohash.org' }
  end

  describe '::DEFAULT_DIRECTORY' do
    it { expect(subject::DEFAULT_DIRECTORY).to eq 'robohash_images' }
  end

  describe '@default_dir' do
    context 'when user redefines the default dir' do
      let(:new_image) { 'new_image' }
      let(:new_default_dir) { './spec/images' }

      it 'is correctly redefined' do
        subject.default_dir = 'my_other_default_dir'

        expect(subject.default_dir).to eq 'my_other_default_dir'

        subject.reset_default_dir
      end

      it 'new images are saved on this directory' do
        subject.default_dir = new_default_dir
        subject.get(new_image)
        subject.reset_default_dir

        expect(File.exists?(File.join("#{new_default_dir}", "#{new_image}.png"))).to be true
      end
    end
  end

  describe '.reset_default_dir' do
    context 'when user resets the default dir' do
      it 'is correctly reseted' do
        subject.reset_default_dir

        expect(subject.default_dir).to eq subject::DEFAULT_DIRECTORY
      end
    end
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

    context 'when a valid name is given' do
      context 'with some options' do
        let(:valid_name) { 'valid_name' }
        let(:options) { { size: :small, set: :human } }
        let(:expected_url) { 'https://robohash.org/valid_name?size=100x100&set=set2' }

        it 'returns the correct URL' do
          method_return = subject.get_url(valid_name, options)
          expect(method_return).to eq expected_url
        end
      end
    end

    context 'when an invalid name is given' do
      let(:invalid_name) { :symbol }

      it 'returns an empty string' do
        method_return = subject.get_url(invalid_name)
        expect(method_return).to eq 'Name should be an non-empty String!'
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

  describe '.get' do
    context 'when a valid name is given' do
      let(:valid_name) { 'valid_name' }

      it 'save the file with that name' do
        subject.get(valid_name)
        expect(File.exists?("./robohash_images/#{valid_name}.png")).to be true
      end
    end

    context 'when a valid name is given' do
      context 'with some options' do
        let(:valid_name) { 'valid_name' }
        let(:options) { { size: :small, set: :human } }

        xit 'save the file with correct formats' do
          # to implement the comparison of downloaded image with the spec image'
          subject.get(valid_name)
          expect(File.exists?("./robohash_images/#{valid_name}.png")).to be true #{spec image to compare}
        end
      end
    end

    context 'when an invalid name is given' do
      let(:invalid_name) { :symbol }

      it 'returns an empty string' do
        method_return = subject.get(invalid_name)
        expect(method_return).to eq 'Name should be an non-empty String!'
      end
    end
  end

  describe '.get_many' do
    context 'when valids names are given' do
      let(:valid_names) { ['valid1', 'valid2', 'valid3'] }

      it 'save each file with its name' do
        subject.get_many(valid_names)
        valid_names.each do |name|
          expect(File.exists?("./robohash_images/#{name}.png")).to be true
        end
      end
    end

    context 'when valid and invalid names are given' do
      let(:valid_names) { ['valid1', 'valid2'] }
      let(:invalid_names) { [:symbol, 1] }

      it 'saves the correct number of files' do
        subject.get_many(valid_names)
        subject.get_many(invalid_names)

        invalid_names.each do |invalid_name|
          expect(File.exists?("./robohash_images/#{invalid_name}.png")).to be false
        end

        valid_names.each do |valid_name|
          expect(File.exists?("./robohash_images/#{valid_name}.png")).to be true
        end
      end
    end

    context 'when valids names are given' do
      context 'with some options' do
        let(:valid_names) { ['valid1', 'valid2', 'valid3'] }
        let(:options) { { size: :small, set: :human } }

        xit 'save each file with the correct formats' do
          # to implement the comparison of downloaded image with the spec image'
          subject.get_many(valid_names)
          valid_names.each do |name|
            expect(File.exists?("./robohash_images/#{name}.png")).to be true #{spec image to compare}
          end
        end
      end
    end

    context 'when no valid names are given' do
      let(:invalid_names) { [Hash.new, 1, :symbol] }

      it 'returns an empty string' do
        method_return = subject.get_many(invalid_names)
        expect(method_return).to eq []
      end
    end
  end
end
