#
# Be sure to run `pod lib lint BaseVCKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'BaseVCKit'
  s.version          = '5.0.0'
  s.summary          = 'Useful utils for UIViewController'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = 'BaseVCKit has potocols & extensions'

  s.homepage         = 'https://github.com/seongkyu-sim/BaseVCKit'

  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'seongkyu-sim' => 'seongkyu.sim@gmail.com' }
  s.source           = { :git => 'https://github.com/seongkyu-sim/BaseVCKit.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'
  s.swift_version = '5.0'
  s.source_files = 'BaseVCKit/Classes/**/*'

  # s.resource_bundles = {
  #   'BaseVCKit' => ['BaseVCKit/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
  s.dependency 'SnapKit'
  s.dependency 'Kingfisher'
end
