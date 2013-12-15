class WebController < UIViewController

  attr_accessor :url
  
  def viewDidLoad
    super
    webView = UIWebView.new
    webView.frame = self.view.frame
    self.view.addSubview(webView)
    webView.loadRequest(NSURLRequest.requestWithURL(NSURL.URLWithString(@url)))
  end

end