class AppDelegate
  attr_accessor :window
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    MagicalRecord.setupCoreDataStackWithStoreNamed("tag.sqlite")
    # self.window.tintColor = BubbleWrap.rgb_color(89, 187, 12)
    true
  end
end
