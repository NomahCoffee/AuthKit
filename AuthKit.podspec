Pod::Spec.new do |spec|

  spec.name         = "AuthKit"
  spec.version      = "1.3"
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
  spec.source_files = ["AuthKit/AuthKitAPI/**/*.swift", "AuthKit/AuthKitUI/**/*.swift"]
  spec.dependency 'Alamofire', '~> 5.2'
  spec.dependency 'SnapKit', '~> 5.0'
  spec.dependency 'NCUtils', '~> 1.4'

end
