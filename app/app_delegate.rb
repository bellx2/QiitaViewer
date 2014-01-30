class AppDelegate < PM::Delegate

  def on_load(app, options)
    NSLog("RUBYMOTION_ENV: " + RUBYMOTION_ENV)
    MagicalRecord.setupCoreDataStackWithStoreNamed("tag.sqlite")
    set_appearance_defaults
    self.window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    
    slider = JASidePanelController.alloc.init
    slider.leftPanel = MenuScreen.new(nav_bar: true).navigationController
    slider.centerPanel = TagScreen.new(nav_bar: true).navigationController
    self.window.rootViewController = slider
    self.window.makeKeyAndVisible
  end

  def set_appearance_defaults
    UINavigationBar.appearance.barTintColor = BubbleWrap.rgb_color(89, 187, 12)
    UINavigationBar.appearance.tintColor = UIColor.whiteColor
    UINavigationBar.appearance.titleTextAttributes = {
      NSForegroundColorAttributeName => UIColor.whiteColor
    }
  end

end

if RUBYMOTION_ENV == 'release'
  def NSLog(msg)
  end
end

