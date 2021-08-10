Gem::Specification.new do |s|
    s.name        = 'CheckSwiftGen'
    s.version     = '0.0.10'
    s.summary     = "Hola!"
    s.description = "A simple checking for repeat call swiftgen"
    s.authors     = ["Ruslan Prokofev"]
    s.email       = 'mefilt@gmail.com'
    s.files  = `git ls-files`.split($\)
    s.bindir = 'bin'
    s.require_paths = ["lib", "bin"]
    s.executables << 'swiftgen_check'
    s.homepage    = 'http://instagram.com/mefilt'
    s.license       = 'MIT'
  end
