require 'formula'

class Perlbrew < Formula
  homepage 'http://perlbrew.pl'
  url 'https://github.com/gugod/App-perlbrew/zipball/release-0.58'
  version '0.58'
  sha1 'ceabbee2c4793afd29e227b8f08721dff003033b'

  head 'git://github.com/gugod/App-perlbrew.git', :branch => 'master'

  def install
    system './perlbrew-install'
  end
end
