Pod::Spec.new do |s|
  s.name         = "Exclusion"
  s.version      = "0.1.0"
  s.summary      = "Customizable URLCache. It can control to store the cache and to respond to the cache."
  s.homepage     = "https://github.com/KyoheiG3/Exclusion"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "Kyohei Ito" => "je.suis.kyohei@gmail.com" }
  s.ios.deployment_target = '8.0'
  s.tvos.deployment_target = '9.0'
  s.source       = { :git => "https://github.com/KyoheiG3/Exclusion.git", :tag => s.version.to_s }
  s.source_files  = "Exclusion/**/*.{h,swift}"
  s.requires_arc = true
  s.frameworks = "Foundation"
end
