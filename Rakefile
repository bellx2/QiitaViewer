# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/ios'

begin
  require 'bundler'
  Bundler.require
rescue LoadError
end

require 'rubygems'
require 'bubble-wrap'
require 'motion-cocoapods'

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'RMQiita'
  app.info_plist['UIMainStoryboardFile'] = 'Storyboard'
  # app.device_family = [:ipad]

  app.pods do
    pod 'SVProgressHUD'
  end

end
