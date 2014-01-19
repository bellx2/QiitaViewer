class AppDelegate
  attr_accessor :window
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    NSLog("RUBYMOTION_ENV: " + RUBYMOTION_ENV)
    MagicalRecord.setupCoreDataStackWithStoreNamed("tag.sqlite")

    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @slider = JASidePanelController.alloc.init
    @storyboard = UIStoryboard.storyboardWithName('Storyboard', bundle:nil)
    @slider.leftPanel = @storyboard.instantiateViewControllerWithIdentifier("leftViewController")
    @slider.centerPanel = @storyboard.instantiateViewControllerWithIdentifier("centerViewController")

    @window.rootViewController = @slider;
    @window.makeKeyAndVisible

    true
  end
end

if RUBYMOTION_ENV == 'release'
  def NSLog(msg)
  end
end
