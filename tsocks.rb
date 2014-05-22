require "formula"

class Tsocks < Formula
  homepage "http://tsocks.sourceforge.net/"
  url "http://downloads.sourceforge.net/project/tsocks/tsocks/1.8%20beta%205/tsocks-1.8beta5.tar.gz"
  version "1.8-beta5"
  sha1 "489f88c5df999ba21b27cdaa7836d9426d062aec"

  depends_on 'autoconf' => :build

  patch :p0 do
    url 'http://marc-abramowitz.com/download/tsocks-1.8_macosx.patch'
    sha1 '001b499c0883b1b7a27eefc1f3a301be2f4960b9'
  end

  def install
    system 'autoconf'
    system './configure', "--prefix=#{prefix}", "--with-conf=#{etc / 'tsocks.conf'}", "--libdir=#{lib}"
    system 'make'
    system 'make', 'install'
  end
end
