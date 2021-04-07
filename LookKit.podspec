Pod::Spec.new do |spec|
    spec.name         = "LookKit"
    spec.version      = "0.0.2"
    spec.summary      = "The world's simplest Computer Vision API for iOS and macOS developers."
    spec.homepage       =  "https://github.com/LA-Labs/LookKit"
    spec.author            = { 'La-Labs' => 'lalabsproducts@gmail.com' }
    spec.license           = { :type => 'MIT', :file => 'LICENSE' }
    spec.description  = <<-DESC
    Computer vision framework for mobile.
    DESC
    spec.platform     = :ios, "13.0"
    spec.ios.deployment_target = "13.0"
    spec.source        = { :git => "https://github.com/LA-Labs/LookKit.git", :tag => "#{spec.version}" }
    spec.vendored_frameworks = "LookKit.xcframework"
end
