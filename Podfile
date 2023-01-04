# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'ContactApp' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  pod 'ZohoAuth'
  pod 'ZCCoreFramework'
  end
  post_install do |installer|
  installer.generated_projects.each do |project|
  project.targets.each do |target|
  target.build_configurations.each do |config|
  config.build_settings['CODE_SIGNING_ALLOWED'] = 'NO'
  end
  end
  end
  # Pods for ContactApp

end
