Gem::Specification.new do |s|
  s.name = 'heartcheck-s3'
  s.authors = ['Daniel Cunha']
  s.version = '0.0.1'
  s.summary = 'A plugin to check S3 connection with heartcheck'
  s.license = 'GPL-3.0'
  s.files = Dir['lib/**/*', 'README*']
  s.homepage = 'https://github.com/dccunha/heartcheck-s3'

  s.add_dependency 'heartcheck', '~> 1.0', '>= 1.0.0'

  s.add_development_dependency 'rspec'
end
