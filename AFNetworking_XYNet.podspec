#
# Be sure to run `pod lib lint AFNetworking_XYNet.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'AFNetworking_XYNet'
  s.version          = '0.1.0'
  s.summary          = 'AFNetworking基础上封装的网络框架'
  s.description      = 'AFNetworking基础上封装的网络框架,尚未完成'
  
  s.homepage         = 'https://github.com/XiaoYuEngineer'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'songzy1989@163.com' => 'songzy1989@163.com' }
  s.source           = { :git => 'https://github.com/XiaoYuEngineer/AFNetworking_XYNet.git', :tag => s.version.to_s }
  
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
  s.ios.deployment_target = '8.0'
  s.source_files = 'AFNetworking_XYNet/Classes/**/**/*'
  # s.resource_bundles = {
  #   'AFNetworking_XYNet' => ['AFNetworking_XYNet/Assets/*.png']
  # }
  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
   s.dependency 'AFNetworking', '~> 3.1.0'
   
end
