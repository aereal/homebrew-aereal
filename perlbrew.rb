require 'formula'

class Perlbrew < Formula
  homepage 'http://perlbrew.pl'
  url 'https://github.com/gugod/App-perlbrew/zipball/release-0.58'
  version '0.58'
  sha1 '4b98c8509f65a9ffe665afdf987109839c93e47e'

  head 'git://github.com/gugod/App-perlbrew.git', :branch => 'master'

  def install
    system './perlbrew-install'
  end
end
