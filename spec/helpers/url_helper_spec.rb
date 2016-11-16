require 'rails_helper'

describe UrlHelper do
  describe '#format_to_http_url' do
    it 'adds http:// to urls' do
      expect(
        described_class.format_to_http_url('google.com')
      ).to eq('http://google.com')
      expect(
        described_class.format_to_http_url('www.google.com')
      ).to eq('http://www.google.com')
    end

    it 'replaces https:// with http://' do
      expect(
        described_class.format_to_http_url('https://google.com')
      ).to eq('http://google.com')
      expect(
        described_class.format_to_http_url('https://www.google.com')
      ).to eq('http://www.google.com')
    end
  end
end
