#
# Be sure to run `pod lib lint ActionsDrawer.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ActionsDrawer'
  s.version          = '0.1.1'
  s.summary          = 'A prettier alternative to action sheets.'
  s.swift_version    = '4.2'

  s.description      = <<-DESC
ActionsDrawer is built as a replacement to the standard action sheets. Action sheets provide little to no customization UI wise, while ActionsDrawer lets you display actions however you want (grouped, with images, etc.) in a scrollable area.
                       DESC

  s.homepage         = 'https://github.com/Prismik/ActionsDrawer'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Francis' => 'francis.beauchamp@finecraftedapps.com' }
  s.source           = { :git => 'https://github.com/Prismik/ActionsDrawer.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'ActionsDrawer/Classes/**/*'

  s.frameworks = 'UIKit'
  s.dependency 'PinLayout', '~> 1.8'
end
