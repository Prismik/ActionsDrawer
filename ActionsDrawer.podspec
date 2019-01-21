#
# Be sure to run `pod lib lint ActionsDrawer.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ActionsDrawer'
  s.version          = '0.1.0'
  s.summary          = 'A prettier alternative to action sheets.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
ActionsDrawer is built as a replacement to the standard action sheets. Action sheets provide little to no customization UI wise, while ActionsDrawer lets you display actions however you want (grouped, with images, etc.) in a scrollable area.
                       DESC

  s.homepage         = 'https://github.com/Francis/ActionsDrawer'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Francis' => 'francis.beauchamp@finecraftedapps.com' }
  s.source           = { :git => 'https://github.com/Francis/ActionsDrawer.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'ActionsDrawer/Classes/**/*'
  
  # s.resource_bundles = {
  #   'ActionsDrawer' => ['ActionsDrawer/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
  s.dependency 'PinLayout', '~> 1.8'
end
