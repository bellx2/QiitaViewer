class WebController < UIViewController

  attr_accessor :url
  
  def viewDidLoad
    super
    # webView = PBWebViewController.new
    # webView.frame = self.view.frame
    # self.view.addSubview(webView)
    # webView.loadRequest(NSURLRequest.requestWithURL(NSURL.URLWithString(@url)))

    webViewController = PBWebViewController.alloc.init
    webViewController.URL = NSURL.alloc.initWithString(@url)
    activity = PBSafariActivity.alloc.init
    webViewController.applicationActivities = [activity]
    webViewController.excludedActivityTypes = [UIActivityTypeMail, UIActivityTypeMessage, UIActivityTypePostToWeibo]
    self.view.addSubview(webViewController)
  end

end