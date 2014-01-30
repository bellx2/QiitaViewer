class WebScreen < PM::WebScreen
  attr_accessor :url

  def on_load

  end

  def content
    NSURL.URLWithString(url)
  end

end