class AppDelegate
  attr_accessor :window
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    #entries_controller = EntriesController.new
    entries_controller = TopicsController.new
    nav_controller = UINavigationController.alloc.initWithRootViewController(entries_controller)
    @window.rootViewController = nav_controller
    @window.makeKeyAndVisible
    true
  end
end
