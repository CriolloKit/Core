Pod::Spec.new do |s|
  s.name         = "CriolloKitCore"
  s.version      = "0.0.1"
  s.summary      = "Core structure for Crillo Kit"

  s.description  = <<-DESC
                Core structure for Crillo Kit
                   DESC

  s.homepage     = "https://github.com/CriolloKit/Core"

  s.license      = 'MIT (example)'
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "Sergey Zenchenko" => "sergeizenchenko@gmail.com" }

  s.platform     = :ios, '6.0'

  s.source       = { :git => "https://github.com/CriolloKit/Core.git", :tag => "0.0.1" }

  s.source_files  = 'Core/Code', 'Core/Code/**/*.{h,m}'

  s.frameworks = 'Foundation'

  s.requires_arc = true
end
