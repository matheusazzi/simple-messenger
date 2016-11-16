module UrlHelper
  HTTP_PROTOCOL = 'http://'

  def self.format_to_http_url(url)
    url = url.gsub('https://', HTTP_PROTOCOL)

    unless url.include?(HTTP_PROTOCOL)
      url = HTTP_PROTOCOL + url
    end

    url
  end
end
