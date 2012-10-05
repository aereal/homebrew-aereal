require 'formula'

class Perlbrew < Formula
  homepage 'http://perlbrew.pl'
  url 'https://github.com/gugod/App-perlbrew/zipball/release-0.52'
  version '0.52'
  sha1 'fcccf0f366a03b663a4632f94f51e3ddc9df41f1'

  head 'git://github.com/gugod/App-perlbrew.git', :branch => 'master'

  def install
    system './perlbrew-install'
  end
end
