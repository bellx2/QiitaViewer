# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/ios'

begin
  require 'bundler'
  Bundler.require
rescue LoadError
end

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  require 'yaml'
  config = YAML::load_file('./config.yml')
  
  app.name = 'RMQiita'
  app.version = "1.2"
  app.short_version = "1.2"

  app.info_plist['UIMainStoryboardFile'] = 'Storyboard'

  app.identifier = config['app']['identifier']  
  app.testflight.api_token  = config['testflight']['api_token']
  app.testflight.team_token = config['testflight']['team_token']
  app.testflight.app_token  = config['testflight']['app_token']
  app.testflight.distribution_lists = config['testflight']['distribution_list']
  app.testflight.notify = false # default is false
  app.testflight.identify_testers = false # default is false
  app.testflight.sdk = 'vendor/TestFlight'

  app.pods do
    pod 'SVProgressHUD'
    pod 'JASidePanels'
    pod 'MagicalRecord'
    pod 'PBWebViewController', :git =>'https://github.com/Palringo-Dev/PBWebViewController.git'
  end

  app.codesign_certificate = config['app']['codesign_certificate']

  # app.frameworks = ["UIKit", "Foundation", "CoreGraphics"]
  # app.icons = ["Icon.png", "Icon-72.png", "Icon@2x.png"] 
  # app.prerendered_icon = false
  # app.device_family = [:ipad]
  # app.interface_orientations = [:portrait, :landscape_left, :landscape_right]  
  # app.sdk_version = "7.0" 

end
