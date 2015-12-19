HOMEBREW_FORMULAE_PREFIX = File.join(`brew --prefix`.strip, 'Library/Formula')
SOURCE_FORMULAE = `git ls-files --cached -z -- *.rb`.split("\0")
TARGET_FORMULAE = SOURCE_FORMULAE.map {|f| File.join(HOMEBREW_FORMULAE_PREFIX, f) }

rule %r{#{HOMEBREW_FORMULAE_PREFIX}/[^./]+\.rb} => "%f" do |t|
  cp t.source,t.name
end

desc "Install formulae"
task install: TARGET_FORMULAE
task default: :install
