require 'rails_helper'

describe Attachment do
  it { should belong_to(:message) }

  describe 'validation' do
    context 'when image_url present' do
      it 'validates only presence of image_url' do
        attach = described_class.new({
          image_url: 'http://www.google.com/logo.jpg',
          message: Message.new
        })
        expect(attach).to be_valid
      end
    end

    context 'when no image_url present' do
      it 'validates presence of title, title_url and description' do
        attach = described_class.new({
          title: 'title',
          title_url: 'http://www.google.com/',
          description: 'desc',
          message: Message.new
        })
        expect(attach).to be_valid

        attach = described_class.new(message: Message.new)
        expect(attach).to be_invalid
        expect(attach.errors.keys).to include(:title, :title_url, :description)
      end
    end
  end
end
