#
# Be sure to run `pod lib lint UITableViewAgent.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'UITableViewAgent'
  s.version          = '0.2.0'
  s.summary          = '✅ Be your UITableViewDelegate and UITableViewDataSource, make your TableView easier to use.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
✅ Be your UITableViewDelegate and UITableViewDataSource, make your TableView easier to use.
                       DESC

  s.homepage         = 'https://github.com/cba023/UITableViewAgent'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'cba023' => 'cba023@hotmail.com' }
  s.source           = { :git => 'https://github.com/cba023/UITableViewAgent.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'UITableViewAgent/Classes/**/*'
  s.swift_version = '5.0'
  
  # s.resource_bundles = {
  #   'UITableViewAgent' => ['UITableViewAgent/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
  s.dependency 'TableViewReuse', '~> 0.2.0'
end
