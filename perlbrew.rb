require 'formula'

class Perlbrew < Formula
  homepage 'http://perlbrew.pl'
  url 'https://github.com/gugod/App-perlbrew/tarball/release-0.43'
  sha1 '1fdc71150c4316f94d2038804a2e895125816ab3'

  head 'git://github.com/gugod/App-perlbrew.git', :branch => 'master'

  def install
    system './perlbrew-install'
  end
end
