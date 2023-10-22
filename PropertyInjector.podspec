#
# Be sure to run `pod lib lint PropertyInjector.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'PropertyInjector'
  s.version          = '0.0.11'
  s.summary          = 'Property dependency injection framework for Swift.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Property dependency injection framework for Swift 5.1+ and iOS 11+.
Declare your dependencies and use them as properties in your classes.
                       DESC

  s.homepage         = 'https://github.com/stanfeldman/PropertyInjector'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Stan Feldman' => 'stanislavfeldman@gmail.com' }
  s.source           = { :git => 'https://github.com/stanfeldman/PropertyInjector.git', :tag => s.version.to_s }
  s.swift_version = '5.5'
  s.ios.deployment_target = '13.0'
  s.source_files = 'PropertyInjector/Classes/**/*'
end
