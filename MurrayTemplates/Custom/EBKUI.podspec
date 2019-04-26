Pod::Spec.new do |s|
  s.name             = '{{ name }}'
  s.version          = '1.0.0'
  s.summary          = 'Collection of UI elements used on the EBK app'

  s.homepage         = 'https://github.corp.ebay.com/eBay-Kleinanzeigen/ios-client'
  s.license          = { :type => 'Closed', :file => 'LICENSE' }
  s.author           = { 'eBay Kleinanzeigen' => 'development@ebay-kleinanzeigen.de' }
  s.source           = { :git => 'https://github.corp.ebay.com/eBay-Kleinanzeigen/ios-client.git', :tag => s.version.to_s }

  s.ios.deployment_target = '11.0'

  s.swift_version = '4.2'

  s.frameworks = 'UIKit'
  s.source_files = 'EBKUI/Classes/**/*'  
  s.resource_bundles = {
    'Images' => ['EBKUI/Assets/**/*']
  }
 
  s.public_header_files = 'EBKUI/Classes/**/*.h'
end
