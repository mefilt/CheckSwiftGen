Gem::Specification.new do |s|
    s.name        = 'CheckSwiftGen'
    s.version     = '0.0.11'
    s.summary     = "Hola!"
    s.description = "A simple checking for repeat call swiftgen"
    s.authors     = ["Ruslan Prokofev"]
    s.email       = 'mefilt@gmail.com'
    s.files  = `git ls-files`.split($\)
    s.bindir = 'bin'
    s.require_paths = ["lib", "bin"]
    s.executables << 'swiftgen_check_for_new'
    s.homepage    = 'http://instagram.com/mefilt'
    s.license       = 'MIT'
  end
