class WebController < UIViewController

  attr_accessor :tag
  
  def viewDidLoad
    super
    ud = NSUserDefaults.standardUserDefaults
    @url = ud["url"]

    webView = UIWebView.new
    webView.frame = self.view.frame
    self.view.addSubview(webView)
    webView.loadRequest(NSURLRequest.requestWithURL(NSURL.URLWithString(@url)))
  end

end