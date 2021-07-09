Pod::Spec.new do |spec|

  spec.name         = "AuthKit"
  spec.version      = "1.0"
  spec.summary      = "An authentication framework for all Nomah Coffee iOS host applications."
  spec.description  = <<-DESC
This library is an authentication framework for any Nomah Coffee iOS applications.
It handles both the networking and the UI work related to any sort of authentication work.
                   DESC
  spec.homepage     = "https://github.com/NomahCoffee/AuthKit"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author       = { "Caleb Rudnicki" => "calebrudnicki@gmail.com" }
  spec.ios.deployment_target = "13.0"
  spec.swift_version = "5.0"
  spec.source        = { :git => "https://github.com/NomahCoffee/AuthKit.git", :tag => "#{spec.version}" }
  spec.source_files  = "AuthKit/**/*.{h,m,swift}"
  spec.requires_arc = true
  spec.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  spec.dependency 'Alamofire', '~> 5.2'
  spec.dependency 'SwiftyJSON', '~> 4.0'
  spec.dependency 'SnapKit', '~> 5.0'
  spec.dependency 'NCUtils', '~> 1.1'

end
